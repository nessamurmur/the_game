# TheGame

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

GET     /api/classes
GET     /api/classes/:id
POST    /api/classes
PATCH   /api/classes/:id
PUT     /api/classes/:id
DELETE  /api/classes/:id

### Users

GET     /api/users
GET     /api/users/:id/edit
GET     /api/users/new
GET     /api/users/:id
POST    /api/users
PATCH   /api/users/:id
PUT     /api/users/:id
DELETE  /api/users/:id
