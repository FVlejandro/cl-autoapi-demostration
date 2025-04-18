#!bin/bash

#Parametros necesarios para Ejecutar Runner
protocol=$1
tags=($2)
host=$3

#rutas
collections_route="./collections/"
environments_route="./environments/"
scripts_route="./scripts/"

# Comprobamos si se han pasado los parámetros necesarios
while getopts "p:t:h:" opt; do
  case $opt in
    p) protocol="$OPTARG"
    ;;
    t) tags=($OPTARG)
    ;;
    h) host="$OPTARG"
    ;;
  esac
done

#Depuración de los parametros Ingresados
echo "###################################################### Parametros URL ##########################################################"
if [[ -z "$protocol" ]]; then
    echo "Protocolo URL --> : No Ingresado"
    continue
else 
    echo "Protocolo URL --> : $protocol"
fi

if [[ -z "$host" ]]; then
    echo "Host URL --> : No Ingresado"
    continue
else
    echo "Host URL --> : $host"
fi

echo -e "####################################################################################################################################\n"

echo "###################################################### [i] Parametros Tag ############################################################"
if [[ ${#tags[@]} -eq 0 ]]; then
    echo "Tag --> : No Ingresado"
    continue 
else
    echo "Tags Ingresados --> : ${tags[@]}"
fi
echo -e "####################################################################################################################################\n"


#Se crea un array el cual guarda los nombres de las colecciones en el directorio collections
executions=()
while IFS= read -r -d $'\0' collection; do
    executions+=("$(basename "$collection")")
done < <(find "$collections_route" -maxdepth 1 -type f -print0)

#Main Loop
for collection in "${executions[@]}"; do
    echo -e "###################################################### [i] Ejecución de la colección --> $collection ##########################################################\n"
    

    #Se crea el path del environment
    env_name="$(echo "$collection" | sed 's/\.postman_collection\.json$/.postman_environment.json/')" # Reemplazamos la extensión de collection por el de environment
    env_file="$environments_route$env_name" #creamos el path del environment

    if [[ ! -f "$env_file" ]]; then
        echo "Environment File --> : No se Encontró archivo el Archivo Environment Correspondiente"
        exit 1
    fi

    echo "Environment File --> : $env_file"

    #Logica de Variables
    env_vars=()
    while IFS= read -r var; do
      var_clean=$(tr -d '\r' <<< "$var")
      case "$var_clean" in
        "tag")
          env_vars+=("--env-var")
          env_vars+=("$var_clean=$tag")
          ;;
        "protocol")
          env_vars+=("--env-var")
          env_vars+=("$var_clean=$protocol")
          ;;
        "host")
          env_vars+=("--env-var")
          env_vars+=("$var_clean=$host")
          ;;
      esac
    done < <(jq -r '.values[] | select(.value == "") | .key' "$env_file" | sort -u)

    #Se construye comando Newman para la ejecución
    newman_command=(
      newman
      run "$collections_route$collection"
      -e "$env_file"
      --delay-request 2000
      "${env_vars[@]}"
    )

    # Lógica de Tags
    env_tag=$(jq -r '.values[] | select(.key == "tag") | .value' "$env_file" | sort -u)
    echo "[i] tag from Collection --> : $env_tag"

    should_run=true
    if [[ -n "$tags" && -n "$env_tag" ]]; then
      should_run=false
      for tag in "${tags[@]}"; do
        if [[ "$tag" == "$env_tag" ]]; then
          should_run=true
          break
        fi
      done
      if [[ "$should_run" == "false" ]]; then
        echo -e "################################ [!] Saltando Ejecución de $collection --> : $env_tag no coincide con los tags proporcionados --> ${tags[@]} ################################\n"
        continue
      fi
    fi

    # Comando Construido con Newman
    echo "[i] Comando Construido --> : ${newman_command[@]}"

    # Ejecución del comando
    if [[ "$should_run" == "true" ]]; then
      eval "${newman_command[@]}"
    fi

    echo "###################################################### [i] Fin Ejecución de $collection ##########################################################"
    
done





