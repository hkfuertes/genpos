## Herramienta de ayuda a la generadion de grupos en el aula: Test Sociométricos
Este es el repositorio donde se aloja la herramienta, asi como la documentación:
- (Aquí)[doc/tfm_mfp19.pdf] puedes ver el trabajo escrito.
- La carpeta **server** contiene realmente el codigo. Esta escrito en Ruby on Rails.

### Funcionamiento
Para levantar el entorno basta con rellenar el siguiente fichero (`.env.dist`) con los valores apropiados, y guardarlo en un fichero `.env` sin el ".dist" del final:
```env
MYSQLHOST=database
MYSQLUSER=root
MYSQLPASSWORD=password
MYSQLDATABASE=genpos

PORT=80
SECRET_KEY=SECRET_KEY

TEACHER_EMAIL=profesor@enrollado.com
TEACHER_PASSWORD=enrollado
TEACHER_NAME=Profesor
TEACHER_LAST_NAME=Enrollado
```
> Las variables _teacher_ son para definir el primer profesor en la base datos, este sera administrador.

Y ejecutar el comando de docker-compose:
```bash
docker-compose up
```