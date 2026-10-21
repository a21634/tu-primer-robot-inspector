
#!/usr/bin/env bash

# ==========================================================
# Proyecto: Tu primer robot inspector
# Descripcion: Analiza logs y genera un reporte de alertas.
# ==========================================================

# Activar un comportamiento seguro para el script.
set -u
set -o pipefail

# Obtener la ubicacion del proyecto a partir de este script.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Definir las rutas de entrada y salida.
LOG_FILE="$PROJECT_DIR/logs/servidor.log"
REPORT_DIR="$PROJECT_DIR/reportes"
REPORT_FILE="$REPORT_DIR/alerta_de_hoy.txt"

# Obtener el usuario y la fecha de ejecucion.
USUARIO="$(whoami)"
FECHA_EJECUCION="$(date '+%Y-%m-%d %H:%M:%S %Z')"

# Comprobar que las herramientas necesarias estan disponibles.
for comando in grep date whoami; do
    if ! command -v "$comando" >/dev/null 2>&1; then
        printf 'ERROR: No se encontro el comando requerido: %s\n' "$comando" >&2
        exit 1
    fi
done

# Comprobar que existe el archivo de registros.
if [[ ! -f "$LOG_FILE" ]]; then
    printf 'ERROR: No existe el archivo de logs: %s\n' "$LOG_FILE" >&2
    exit 1
fi

# Crear la carpeta de reportes si todavia no existe.
if ! mkdir -p "$REPORT_DIR"; then
    printf 'ERROR: No se pudo crear la carpeta de reportes.\n' >&2
    exit 1
fi

# Crear un archivo temporal para almacenar los hallazgos.
if ! ARCHIVO_TEMPORAL="$(mktemp)"; then
    printf 'ERROR: No se pudo crear el archivo temporal.\n' >&2
    exit 1
fi

# Eliminar el archivo temporal al terminar, incluso si hay un fallo.
trap 'rm -f -- "$ARCHIVO_TEMPORAL"' EXIT

# Filtrar los registros ERROR y CRITICAL, sin distinguir mayusculas.
# grep devuelve 0 si encuentra coincidencias, 1 si no encuentra
# ninguna y un codigo mayor si ocurre un error de ejecucion.
if grep -E -i '^(ERROR|CRITICAL):' "$LOG_FILE" > "$ARCHIVO_TEMPORAL"; then
    HAY_ALERTAS=1
else
    ESTADO_GREP=$?

    if [[ "$ESTADO_GREP" -eq 1 ]]; then
        HAY_ALERTAS=0
    else
        printf 'ERROR: No se pudo analizar el archivo de logs.\n' >&2
        exit 1
    fi
fi

# Contar las alertas encontradas.
TOTAL_ALERTAS="$(wc -l < "$ARCHIVO_TEMPORAL")"

# Generar el reporte con encabezado, contexto y resultados.
{
    printf '%s\n' '=============================================='
    printf '%s\n' '       REPORTE DEL ROBOT INSPECTOR'
    printf '%s\n' '=============================================='
    printf 'Fecha de ejecucion: %s\n' "$FECHA_EJECUCION"
    printf 'Usuario que genero el reporte: %s\n' "$USUARIO"
    printf 'Archivo analizado: %s\n' "$LOG_FILE"
    printf 'Total de alertas encontradas: %s\n' "$TOTAL_ALERTAS"
    printf '%s\n' '----------------------------------------------'
    printf '%s\n' 'DETALLE DE ALERTAS'
    printf '%s\n' '----------------------------------------------'

    if [[ "$HAY_ALERTAS" -eq 1 ]]; then
        # Mostrar cada alerta con la fecha y hora de ejecucion.
        while IFS= read -r linea; do
            printf '[%s] %s\n' "$(printf '%s' "$FECHA_EJECUCION" | sed 's/[[:space:]]*$//')" "$linea"
        done < "$ARCHIVO_TEMPORAL"
    else
        printf '%s\n' 'No se encontraron errores ni fallos criticos.'
    fi

    printf '%s\n' '=============================================='
    printf '%s\n' 'Fin del reporte.'
} > "$REPORT_FILE" || {
    printf 'ERROR: No se pudo escribir el reporte: %s\n' "$REPORT_FILE" >&2
    exit 1
}

# Mostrar el resultado de la ejecucion en la terminal.
printf 'Inspeccion completada correctamente.\n'
printf 'Alertas encontradas: %s\n' "$TOTAL_ALERTAS"
printf 'Reporte generado en: %s\n' "$REPORT_FILE"
