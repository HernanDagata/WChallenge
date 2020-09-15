Feature: Prueba Invalidar sesion del usuario

  Como usurio de la aplicacion
  Quiero realizar la invalidacion de una sesion
  Para que el usuario no pueda continuar navegando en la aplicacion

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  @Invalidar
  Scenario: Invalidar sesion usuario regular
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoRegular')
    * def varAuthorization = jsonAutenticacion.responseHeaders.Authorization[0]
    Given url urlBase + 'users/sessions/invalidate_all'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    And request {}
    When method post
    Then status 200
    Given url urlBase + 'albums'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 401
    And match response contains read('../json/formato_error.json')

  @Invalidar
  Scenario: Invalidar sesion usuario administrador
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoAdministrador')
    * def varAuthorization = jsonAutenticacion.responseHeaders.Authorization[0]
    Given url urlBase + 'users/sessions/invalidate_all'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    And request {}
    When method post
    Then status 200
    Given url urlBase + 'albums'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 401
    And match response contains read('../json/formato_error.json')