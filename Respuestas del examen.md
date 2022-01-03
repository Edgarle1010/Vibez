Para la realización del pryecto se utilizo el patron de diseño MVC (Model View Controller) principalmente por la razón de ser un proyecto pequeño y no se saturan de codigo los controllers. También se utilizó el patron de diseño Delegation para el acceso a los datos de la API.


8. Explique el ciclo de vida de un view Controller

 - El ciclo de vida de un view controller son ciertos momentos claves que podemos aprovechar y escribir código para 
 especificar lo que debería suceder en esos momentos. iOS automaticamente llama estos metodos
 - Lo primero que sucede es que la vista se carga: todos los objetos relacionados con la vista se conectan y ahora son accesibles. (viewDidLoad)
 - Después de cargar la vista, lo siguiente que llamará el sistema operativo es viewWillAppear; se carga justo antes de que la vista aparezca en pantalla. El usuario aún no puede ver nada, podremos ocultar o mostrar ciertos componenetes.
 - viewDidAppear, el usuario ya puede ver realmente las cosas en pantalla.
 - viewWillDisappear, se desencadena cuando de alguna manera se descartó el view controller, por ejemplo: ir hacia la pantalla anterior. Es buen momento para detener animaciones, etc.
 - viewDidDisappear, la vista ya esta fuera de la pantalla, literalmente significa que el usuario no puede ver la vista, aún no se destruye el view controller de la memoria.
 


9. Explique el ciclo de vida de una aplicación

- Generalmente comienza con App Launched y luego App Visble, cuando la aplicación retrocede a segundo plano pasa a App Recedes into Background y finalmente la aplicación es destruido cuando iOS asigna los recursos a otra aplicación.
- La ultima parte es la clave para entende el ciclo de vida, ya que, los recursos de un movil son limitados y el sistema operativo siempre tiene que decidir como asignar estos recursos. Priorizando las aplicaciones que esten en primer plano
- Ejemplo: es importante saber cuando guardar los datos de un usario justo cuando la aplicación esta en segundo plano, para evitar que se pierda, por ejemplo, los datos introducidos en un formulario complejo.
- Cabe destacar que con la llegada de iOS 13, se implementaron más elementos al ciclo de vida (Scene Delegate) ya que las aplicaciones pueden ejecutarse en multiples ventanas (iPadOS)

10.

 - Weak se debe usar cuando el atributo puede valer nil en alguna parte de su ciclo de vida
 - Unowned se debe usar cuando está garantizado que ese atributo siempre tendrá un valor
 - Si no se especifica la referencia al crear una variable, la misma es strong
 
 

11. ARC: Automatic Reference Counting (Contador de referencias automático)

 - El contador de referencias automático es una funcionalidad que permite liberar la memoria de aquellos elementos que no posean referencias fuertes hacia ellos (strong references).
 - ARC libera la memoria cuando la cantidad de referencias strong es igual a 0
 
 
 
 12. 
 
  - El color de la vista será .yellow. Ya que cuando se ejecuta instantiateViewController se ejecuta el viewDidLoad del controller con color rojo y al estar la siguiente linea de codigo que lo modifica al amarillo, es el ultimo cambio de color que se ejecuta.

