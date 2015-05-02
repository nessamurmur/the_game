# TheGame

[![Build Status](https://travis-ci.org/niftyn8/the_game.svg)](https://travis-ci.org/niftyn8/the_game)

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.


## API

### Characters


#### List all characters

`GET     /api/characters`

Returns a list of characters

**Example**:

`curl http://thegame.com/characters`

#### Get a character

`GET     /api/characters/:id`

Returns a single character who's id == :id

**Query Params**:
id :: Integer

**Example**:

`curl http://thegame.com/characters/1`

#### Create a character

`POST    /api/characters`

**Params**:
*Required*:
* name :: String
* level :: Integer
* class_id :: Integer
* user_id :: Integer

#### Update a character

`PATCH   /api/characters/:id`
`PUT     /api/characters/:id`

**Params**:
*Optional*:
* name :: String
* level :: Integer
* class_id :: Integer
* user_id :: Integer

#### Destroy a character

`DELETE  /api/characters/:id`


### Classes

#### Get a list of available classes

`GET     /api/classes`

**Example**:
`curl http://thegame.com/api/classes`

#### Get a particular class

`GET     /api/classes/:id`

#### Create a new class

`POST    /api/classes`

**Params**:
*Required*:
* name :: String

#### Update a class

`PATCH   /api/classes/:id`
`PUT     /api/classes/:id`

**Params**:
*Required*:
* name :: String

#### Delete a class

`DELETE  /api/classes/:id`

### Users

#### Get all users

`GET     /api/users`

#### Get a particular user

`GET     /api/users/:id`

### Create a user

`POST    /api/users`

**Params**:
*Required*:
* name :: String
* username :: String
* key :: String - a unique device identifier
* lat :: Ingteger
* long :: Integer

#### Update a user

`PATCH   /api/users/:id`
`PUT     /api/users/:id`

**Params**:
*Optional*:
* name :: String
* username :: String
* lat :: Ingteger
* long :: Integer

#### Delete a user

`DELETE  /api/users/:id`
