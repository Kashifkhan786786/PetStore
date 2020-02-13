Feature: Demo Pet Test

Background:
* def requestURL = 'https://petstore.swagger.io/v2/pet'
* def authentication = call read('Authentication.feature')
* def authToken = mauthentication.accessToken 

Scenario: Positive Insert Some Pet Data

Given path ''
	
	* def pet =
      """
     	 {
  		"id": 1212,
  		"category": {
	    	"id": 0,
	    	"name": "Dog122"
  		},
  		"name": "doggie122",
  		"photoUrls": [
    		"NoTestPhoto"
  		],
  		"tags": [
    		{
	      		"id": 0,
	      		"name": "NotestTag"
    		}
  		],
  		"status": "available"
	}
      """
	When URL requestURL
	And header Authorization = authToken
	Then Method Post
	And status 200

Scenario: Negative Wrong Pet Data Type ID
	* def pet =
      """
     	 {
  		"id": "WrongID",
  		"category": {
	    	"id": 0,
	    	"name": "Dog122"
  		},
  		"name": "doggie122",
  		"photoUrls": [
    		"NoTestPhoto"
  		],
  		"tags": [
    		{
	      		"id": 0,
	      		"name": "NotestTag"
    		}
  		],
  		"status": "available"
	}
      """
	When URL requestURL
	And header Authorization = authToken
	Then Method Post
	Then status 405

Scenario: Negative Wrong Pet Data Type Name
	* def pet =
      """
     	 {
  		"id": 1211,
  		"category": {
	    	"id": 0,
	    	"name": "Dog122"
  		},
  		"name": "0000",
  		"photoUrls": [
    		"NoTestPhoto"
  		],
  		"tags": [
    		{
	      		"id": 0,
	      		"name": "NotestTag"
    		}
  		],
  		"status": "available"
	}
      """
	When URL requestURL
	And header Authorization = authToken
	Then Method Post
	Then status 405

Scenario: Negative Wrong Pet Data Type Status
	* def pet =
      """
     	 {
  		"id": 1213,
  		"category": {
	    	"id": 0,
	    	"name": "Dog122"
  		},
  		"name": "Doggie",
  		"photoUrls": [
    		"NoTestPhoto"
  		],
  		"tags": [
    		{
	      		"id": 0,
	      		"name": "NotestTag"
    		}
  		],
  		"status": "1234"
	}
      """
	When URL requestURL
	And header Authorization = 'Bearer' + authToken
	Then Method Post
	Then status 405

Scenario: Security Wrong Header
	* def pet =
      """
     	 {
  		"id": 1234,
  		"category": {
	    	"id": 0,
	    	"name": "Dog122"
  		},
  		"name": "Doggie",
  		"photoUrls": [
    		"NoTestPhoto"
  		],
  		"tags": [
    		{
	      		"id": 0,
	      		"name": "NotestTag"
    		}
  		],
  		"status": "1234"
	}
      """
	When URL requestURL
	And header Authorization = WrongHeader
	Then Method Post
	Then status 401