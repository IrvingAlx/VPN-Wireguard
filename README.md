# VPN con WireGuard y Docker

Dos configuraciones de VPN autoalojada con WireGuard y Docker, administradas desde la interfaz web de [wg-easy](https://github.com/wg-easy/wg-easy).

## Configuraciones

| Carpeta | Para qué |
| --- | --- |
| `VPN_Normal` | VPN estándar: los clientes se conectan y salen por el servidor |
| `VPN_Reglas` | VPN restringida: el servidor bloquea todo el tráfico excepto el túnel, la resolución DNS y una página web local, con reglas `iptables` en política DROP |

## Cómo correrlas

1. Copia `.env.example` a `.env` y define `WG_HOST` (IP o dominio del servidor) y `WG_PASSWORD` (contraseña de la interfaz web).
2. **VPN normal:** entra a `VPN_Normal` y ejecuta `docker-compose up -d --build`.
3. **VPN restringida:** entra a `VPN_Reglas` y ejecuta `chmod +x comandos.sh && ./comandos.sh`. El script levanta los contenedores, aplica las reglas de firewall y copia la página de bienvenida.
4. Abre la interfaz web en el puerto `51821`, crea los clientes y descarga su configuración. El tráfico WireGuard usa el puerto `51820/udp`.

## Seguridad

No se publican llaves ni contraseñas: las configuraciones de clientes y servidor se generan en tu máquina y están excluidas por `.gitignore`.

## Stack

WireGuard, Docker Compose, wg-easy, Nginx, iptables.
