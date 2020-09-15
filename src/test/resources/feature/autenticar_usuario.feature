Feature: Prueba autenticacion de usuario

  Como usurio regular de la aplicacion
  Quiero realizar la autenticacion
  Para poder acceder a las transacciones de la aplicacion

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  @ExitosoRegular
  Scenario Outline: Autenticacion exitosa con usuario Regular
    * json jsonLogin = {"email": <newUserMail>, "password": <newUserPassword>}
    Given url urlBase + 'users/sessions/'
    And header Content-Type = headerContentType
    And request jsonLogin
    When method post
    Then status 200
    * print response
    * print responseHeaders['Authorization'][0]
    And match response.user_id == <resultadoEsperadoUserId>
    And match response contains read('../json/formato_autenticacion.json')
    And match responseHeaders['Authorization'][0] == <resultadoEsperadoHeader>

    Examples:
      | newUserMail           | newUserPassword | resultadoEsperadoUserId | resultadoEsperadoHeader |
      | hernan00@wolox.com.ar | Hernan123       | "#number"               | "#notnull"              |

  @ExitosoAdministrador
  Scenario Outline: Autenticacion exitosa con usuario Administrador
    * json jsonLogin = {"email": <newUserMail>, "password": <newUserPassword>}
    Given url urlBase + 'users/sessions/'
    And header Content-Type = headerContentType
    And request jsonLogin
    When method post
    Then status 200
    * print response
    * print responseHeaders['Authorization'][0]
    And match response.user_id == <resultadoEsperadoUserId>
    And match response contains read('../json/formato_autenticacion.json')
    And match responseHeaders['Authorization'][0] == <resultadoEsperadoHeader>

    Examples:
      | newUserMail        | newUserPassword    | resultadoEsperadoUserId | resultadoEsperadoHeader |
      | admin@wolox.com.ar | candidatoWolox2020 | "#number"               | "#notnull"              |

  @Alterno
  Scenario Outline: Autenticacion de usuario fallida
    * json jsonLogin = {"email": <newUserMail>, "password": <newUserPassword>}
    Given url urlBase + 'users/sessions'
    And header Content-Type = headerContentType
    And request jsonLogin
    When method post
    Then status 401
    * print response
    And match response contains read('../json/formato_error.json')

    Examples:
      | newUserMail              | newUserPassword |
      | inexistente@wolox.com.ar | Hernan123       |