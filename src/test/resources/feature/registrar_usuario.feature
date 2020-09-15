Feature: Prueba registro de usuario

  Como usurio regular de la aplicacion
  Quiero realizar el registro en la aplicacion
  Para poder autenticarme en la aplicacion

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  Scenario Outline: Registro de usuario exitoso
    * def jsonUsuario =
   """
   {
   email: "<newUserMail>",
   password: "<newUserPassword>",
   firstName: "<newUserFirstName>",
   lastName: "<newUserLastName>"
   }
   """
    Given url urlBase + 'users'
    And header Content-Type = headerContentType
    And request jsonUsuario
    When method post
    Then status <statusCode>
    * print response
    And match response contains <resultadoEsperado>

    Examples:
      | newUserMail            | newUserPassword | newUserFirstName | newUserLastName | statusCode | resultadoEsperado     |
      | hernan0w0@wolox.com.ar | Hernan123       | Hernan           | Garcia          | 201        | {user_id: '#notnull'} |

  Scenario Outline: Registro de usuario escenarios alternos
    * def jsonUsuario =
   """
   {
   "email": "<newUserMail>",
   "password": "<newUserPassword>",
   "firstName": "<newUserFirstName>",
   "lastName": "<newUserLastName>"
   }
   """
    Given url urlBase + 'users'
    And header Content-Type = headerContentType
    And request jsonUsuario
    When method post
    Then status <statusCode>
    * print response
    And match response == read('../json/formato_error.json')
    And match response.errors[0].message contains <resultadoEsperado>

    Examples:
      | newUserMail            | newUserPassword | newUserFirstName | newUserLastName | statusCode | resultadoEsperado                                      |
      | hernan0w1@wolox.com.co | Herna1**        | Hernan           | Garcia          | 422        | "The email must be @wolox.com.ar"                      |
      | hernan0w2@wolox.com.ar | Herna1**        | Hernan01         | Garcia          | 422        | "firstName"                                            |
      | hernan0w3@wolox.com.ar | Herna1**        | Hernan           | Garcia98        | 422        | "lastName"                                             |
      | hernan0w0@wolox.com.ar | Herna1**        | Hernan           | Garcia          | 422        | "The resource you are trying to create already exists" |
