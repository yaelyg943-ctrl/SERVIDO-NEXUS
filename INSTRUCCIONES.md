# NexusPreds Control Center

Aplicación web privada para registrar cuentas/suscripciones, clientes, proveedores, fechas de vencimiento, ventas, costos y movimientos.

## Qué incluye
- Acceso con usuario y contraseña (Supabase Auth).
- Inventario con modalidad Cuenta completa / Perfil / Plan familiar.
- Propiedad propia o de proveedor.
- Datos de cliente, WhatsApp, correo y datos de acceso opcionales.
- Fechas de inicio y vencimiento; estado calculado automáticamente: activo, por vencer (7 días) o vencido.
- Botón WhatsApp con mensaje de renovación personalizado y formateado.
- Registro manual de entradas y salidas.
- Resumen de ventas, costos y margen bruto estimado.
- Proveedores y búsqueda/filtros.

## Requisitos
Una cuenta gratuita en Supabase y una cuenta gratuita en Vercel o Netlify. No necesitas instalar una base de datos en tu computadora.

## Paso 1 — Crear la base de datos
1. Entra a https://supabase.com/ y crea un proyecto.
2. Guarda la contraseña de base de datos en un lugar seguro.
3. Abre el proyecto y entra a **SQL Editor** > **New query**.
4. Abre `schema.sql`, copia todo su contenido, pégalo en el editor y pulsa **Run**.
5. En **Authentication** > **Providers** > **Email**, deja habilitado Email.
6. En Authentication > URL Configuration, después de publicar, añade la URL de tu web a Site URL y Redirect URLs.

## Paso 2 — Conectar la página con Supabase
1. En Supabase abre **Project Settings** > **API** (o **Data API / API Keys**, según la interfaz).
2. Copia el **Project URL**.
3. Copia la clave pública **anon** o **publishable**. Nunca uses `service_role`, `secret` ni una clave privada en el navegador.
4. Abre `index.html` con un editor de texto.
5. Busca estas dos líneas al principio del script:
   `const SUPABASE_URL = "PEGA_AQUI_TU_SUPABASE_URL";`
   `const SUPABASE_ANON_KEY = "PEGA_AQUI_TU_SUPABASE_ANON_KEY";`
6. Reemplaza los textos de ejemplo con tu URL y tu clave pública. Guarda el archivo.

## Paso 3 — Publicar gratis con Vercel
1. Entra a https://vercel.com/ y crea una cuenta.
2. Descarga y descomprime `nexpreds-control.zip`.
3. En Vercel selecciona **Add New** > **Project**. Puedes importar una carpeta mediante GitHub (recomendado) o usar un despliegue compatible.
4. Para la opción GitHub: crea un repositorio nuevo, sube `index.html` y los demás archivos de esta carpeta; después impórtalo desde Vercel.
5. Framework Preset: **Other**. Build Command y Output Directory se pueden dejar vacíos si despliegas el HTML estático desde la raíz.
6. Pulsa **Deploy**. Vercel te dará una dirección web.
7. Regresa a Supabase > Authentication > URL Configuration y añade esa dirección en Site URL y Redirect URLs.

Alternativa sencilla: Netlify (https://www.netlify.com/): crea un sitio nuevo y arrastra la carpeta descomprimida a la zona de despliegue manual si tu cuenta ofrece esa opción.

## Paso 4 — Crear tu usuario
1. Abre la dirección publicada.
2. Escribe tu correo y una contraseña larga.
3. Pulsa **Crear mi usuario**.
4. Si Supabase solicita confirmación, abre el correo y confirma.
5. Inicia sesión. Tus registros quedarán asociados a ese usuario.

## Uso diario
- **Nueva cuenta:** registra servicio, modalidad, cliente, teléfono, propietario/proveedor y fechas.
- **Vencimientos:** revisa las cuentas por vencer o vencidas; pulsa WhatsApp para abrir el chat con el mensaje ya preparado. Tú decides si lo envías.
- **Entradas y salidas:** registra ingresos/egresos adicionales, por ejemplo compras a proveedor, devoluciones o gastos.
- **Proveedores:** guarda datos de contacto y notas. Asigna el nombre del proveedor también en la ficha de cada cuenta.
- **Editar / eliminar:** desde Cuentas y ventas.

## Importante sobre avisos
La versión inicial calcula vencimientos cuando abres la web y muestra alertas dentro del panel. No puede enviar notificaciones si la página está cerrada. Para eso se puede añadir una automatización diaria (por ejemplo, Supabase Edge Functions + cron y correo/Telegram/WhatsApp API).

## Seguridad de tus datos
- La base de datos tiene Row Level Security (RLS): cada usuario solo puede consultar y modificar sus propios registros.
- Usa únicamente la clave pública anon/publishable en el navegador. Jamás publiques `service_role`.
- La contraseña de streaming se guarda como texto en esta primera versión. Por seguridad, evita almacenar contraseñas reutilizadas o sensibles; usa una bóveda de contraseñas si necesitas proteger credenciales. Para producción conviene añadir cifrado de campos sensibles del lado del servidor.
- No compartas el enlace privado ni las credenciales de Supabase.
- Haz respaldos periódicos desde Supabase.

## Limitaciones conocidas de esta primera versión
- Los mensajes de WhatsApp se abren preparados; no se envían automáticamente.
- El margen mostrado es ventas menos costos capturados en fichas, antes de otros gastos.
- Las entradas automáticas se generan al registrar una nueva cuenta; las salidas y otros movimientos se capturan manualmente.
- No hay todavía notificaciones push, multiusuario por roles, ni cifrado de contraseñas de streaming.
