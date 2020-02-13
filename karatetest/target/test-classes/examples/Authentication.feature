Feature: API Authentication

Background:
* url 'https://petstore.swagger.io/oauth/authorize'

Scenario: Authentication

Given path ''
	When form field Grant_Type = 'Implicit'
	And form field Callback_URL = 'https://petstore.swagger.io/oauth/authorize'
	And form field Auth_URL = 'https://petstore.swagger.io/oauth/authorize'
	And form field Client_ID = 'test'
	And form field Scope = 'read write read:pets write:pets'
	And form field State = 'Username:test Password:abc123'
	And form field Client_Authentication = 'Send client credentials in body'
	And method POST
	Then status 302
	And url 'http://petstore.swagger.io/oauth/login.jsp'
	And form field Username = 'test'
	And form field Password = 'abc123'
	And method POST
	Then status 200
	
* def accessToken = response.access_token
	Then token = 'Bearer' + accessToken
	And print 'token---',token