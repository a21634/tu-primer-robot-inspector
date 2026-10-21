\# Tu Primer Robot Inspector



\## 1. Descripción del proyecto



Tu Primer Robot Inspector es un proyecto de automatización desarrollado con Bash que analiza archivos de registro (\*logs\*) de un servidor para identificar errores (`ERROR`) y alertas críticas (`CRITICAL`).



El script filtra los registros relevantes, cuenta las alertas encontradas y genera un reporte con la fecha y hora de ejecución, el usuario que ejecutó el programa, la ubicación del archivo analizado y el detalle de cada alerta.



Este proyecto demuestra el uso de comandos de Linux, variables de entorno, filtros de texto, redirección de salida y automatización básica para la supervisión de sistemas.



\## 2. Objetivos



\- Automatizar la identificación de errores y alertas críticas en archivos de registro.

\- Practicar el uso de Bash y herramientas de línea de comandos.

\- Generar un reporte organizado que facilite la revisión de incidentes.

\- Comprender cómo la automatización de tareas repetitivas puede contribuir a las prácticas de DevOps y AIOps.



\## 3. Estructura del proyecto



```text

Tu\_Primer\_Robot\_Inspector/

├── logs/

│   └── servidor.log

├── reportes/

│   └── alerta\_de\_hoy.txt

├── scripts/

│   └── inspector.sh

└── README.md

```



\- `logs/servidor.log`: contiene los registros de prueba que serán analizados.

\- `scripts/inspector.sh`: ejecuta el análisis y genera el reporte.

\- `reportes/alerta\_de\_hoy.txt`: contiene el resultado de la inspección.

\- `README.md`: documenta el propósito, los requisitos y el uso del proyecto.



\## 4. Requisitos



\- Git Bash o un entorno compatible con Bash.

\- Comandos `grep`, `date`, `whoami`, `wc`, `mkdir` y `mktemp`.

\- Un archivo de registro disponible en la carpeta `logs/`.



El proyecto se desarrolló y probó en Windows utilizando Git Bash.



\## 5. Cómo ejecutar el robot



1\. Abrir Git Bash.

2\. Acceder a la carpeta del proyecto.

3\. Ejecutar el siguiente comando:



```bash

bash scripts/inspector.sh

```



Si la ejecución termina correctamente, se mostrará un mensaje de confirmación y la cantidad de alertas encontradas.



El reporte se guardará en:



```text

reportes/alerta\_de\_hoy.txt

```



El script utiliza la redirección `>` para generar el reporte desde cero en cada ejecución, evitando que se acumulen resultados antiguos.



\## 6. Comandos utilizados



| Comando | Función |

|---|---|

| `whoami` | Identifica al usuario que ejecuta el script. |

| `date` | Obtiene la fecha y hora de ejecución. |

| `grep` | Busca los registros que coinciden con los patrones definidos. |

| `wc -l` | Cuenta las líneas que contienen alertas. |

| `>` | Escribe la salida en un archivo y reemplaza su contenido anterior. |

| `>>` | Añade contenido al final de un archivo sin borrar lo existente. |

| `bash -n` | Comprueba la sintaxis del script sin ejecutarlo. |

| `git` | Permite controlar las versiones del proyecto. |



\## 7. Resultados de las pruebas



El archivo de registro contiene diez líneas de prueba, distribuidas entre mensajes informativos, errores y alertas críticas.



Los resultados obtenidos fueron:



| Verificación | Resultado |

|---|---:|

| Líneas totales del archivo de registro | 10 |

| Registros `ERROR` | 3 |

| Registros `CRITICAL` | 2 |

| Total de alertas detectadas | 5 |

| Ejecución del script | Correcta |

| Comprobación de sintaxis con `bash -n` | Correcta |



Las comprobaciones independientes con `grep` confirmaron tres errores, dos alertas críticas y cinco alertas en total.



\## 8. Preguntas de análisis



\### ¿Cómo se podría automatizar la ejecución diaria?



En Windows, se puede utilizar el Programador de tareas para ejecutar el script diariamente. La tarea debe configurarse con la ruta del ejecutable de Bash y el script correspondiente. También se recomienda conservar los reportes históricos si se necesita analizar la evolución de los incidentes.



\### ¿Qué ocurriría si el archivo de registro tuviera un millón de líneas?



El script tendría que revisar una cantidad considerablemente mayor de texto. `grep` está diseñado para buscar patrones en archivos grandes, pero el tiempo de ejecución dependería del tamaño real del archivo, el equipo y las condiciones del sistema. Para un entorno de producción convendría evaluar el rendimiento, evitar procesamientos innecesarios y establecer políticas de rotación y conservación de logs.



\### ¿Cómo podría ayudar la inteligencia artificial a identificar la causa raíz de un incidente?



Un sistema de AIOps podría correlacionar los errores con marcas de tiempo, métricas del servidor, cambios recientes y otros registros. Los modelos de análisis podrían detectar patrones anómalos y sugerir causas probables. Sin embargo, las sugerencias deberían contrastarse con evidencias técnicas antes de confirmar una causa raíz.



El robot de este proyecto utiliza reglas explícitas para filtrar alertas; por sí solo, no emplea modelos de inteligencia artificial ni determina automáticamente la causa raíz.



\### ¿Cómo se deberían proteger los archivos de registro?



Se recomienda restringir los permisos de lectura y escritura, evitar almacenar contraseñas o datos personales innecesarios, proteger los archivos frente a modificaciones no autorizadas y establecer políticas de conservación. En entornos sensibles también pueden utilizarse registros centralizados, controles de acceso y mecanismos de auditoría.



\## 9. Utilidad para DevOps y AIOps



La automatización de la inspección de logs reduce el trabajo manual necesario para localizar errores y permite identificar señales que requieren atención.



En DevOps, este tipo de herramienta puede integrarse en procesos de supervisión y mantenimiento. En AIOps, puede servir como una etapa inicial de preparación de datos para sistemas más avanzados de detección de anomalías, correlación de eventos y análisis de incidentes.



La herramienta actual constituye una base educativa: identifica patrones definidos previamente, cuenta alertas y genera un reporte. No reemplaza una plataforma de monitoreo ni realiza análisis predictivo.



\## 10. Limitaciones y mejoras futuras



\- Incorporar pruebas automatizadas para diferentes escenarios.

\- Registrar la fecha y hora real del incidente cuando esté disponible en el log.

\- Añadir niveles de severidad y un resumen por categoría.

\- Integrar notificaciones cuando se detecten alertas críticas.

\- Configurar la ejecución programada y la conservación de reportes históricos.

\- Incorporar herramientas de monitoreo y análisis avanzado en una versión posterior.



\## 11. Conclusión



El proyecto demuestra cómo Bash puede utilizarse para automatizar una tarea básica de supervisión de sistemas. Las pruebas realizadas confirmaron la detección de tres errores y dos alertas críticas, así como la generación del reporte correspondiente.



La solución permite aplicar conceptos iniciales de scripting, análisis de logs, automatización y documentación técnica, y constituye un punto de partida para explorar prácticas más avanzadas de DevOps y AIOps.





