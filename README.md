This is a chat system through this app you can create applications, chat with each application, and message for each chat, also you can search on chat messages

### Tools

1- `Elasticsearch` for chat messages search 

2- `Rabbitmq` for inserting messages and chats into the database

3- `Sidekiq` for updating columns counts

the following steps will explain how you can use this system with examples


First, 
```
copy .env.copy to docker/development/.env path
```
Then, run this command to build the App

```
docker-compose build
```
Then up your App
```
docker-compose up
```

There are multiple endpoints available to you

### Applications

**Create**

```
POST /applications
```

JSON example of request

```json
{
  "application": {
        "name": "App #1"
    }
}
```

JSON example of the response

```json
{
   "application": {
        "name": "App #1",
        "token": "8d6074d115394c14bd50f093d",
        "chats_count": 0,
        "created_at": "2022-11-08T23:18:34.000Z",
        "updated_at": "2022-11-08T23:18:34.000Z"
    }
}
```
**Show**

```
GET /application/:application_token
```

JSON example of the response

```json
{
   "application": {
        "name": "App #1",
        "token": "8d6074d115394c14bd50f093d",
        "chats_count": 0,
        "created_at": "2022-11-08T23:18:34.000Z",
        "updated_at": "2022-11-08T23:18:34.000Z"
    }
}
```
**Update**

```
PUT /application/:application_token
```

JSON example of request
```json
{
  "application": {
        "name": "Updated App #1"
    }
}
```

JSON example of the response
```json
{
    "application": {
        "name": "Updated App #1",
        "token": "ff93d5516c63294f623b72eee",
        "chats_count": 0,
        "created_at": "2022-11-09T21:35:30.000Z",
        "updated_at": "2022-11-09T21:39:39.000Z"
    }
}
```


**Note That**, you will use the application token on any request of the system

### Chats

**Create**

**Note:** this endpoint use rabbitmq

```
POST applications/:application_token/chats
```

**Show all application chats**

```
GET applications/:application_token/chats
```

JSON example of the response
```json
{
    "chats": [
        {
            "chat_number": 1,
            "message_count": 0
        }
    ],
    "meta": {
        "total_entries": 1,
        "total_pages": 1,
        "next_page": null,
        "previous_page": null,
        "current_page": 1,
        "per_page": 10
    }
}
```

**Show**

```
GET applications/:application_token/chats/:number
```

JSON example of the response

```json
{
    "chat": {
        "chat_number": 1,
        "message_count": 0
    }
}
```

### Messages

**Create a new message for a specific application to specific chat**

```
POST /applications/:application_token/chats/:chat_number/messages
```

JSON example of request body
```json
{
  "message": {
    "body": "Hello"
  }
}
```

**Read all chat messages to specific applications**

```
GET /applications/:application_token/chats/:chat_number/messages
```

JSON example of the response

```json
{
    "messages": [
        {
            "body": "Hello",
            "message_number": 1
        }
    ],
    "meta": {
        "total_entries": 1,
        "total_pages": 1,
        "next_page": null,
        "previous_page": null,
        "current_page": 1,
        "per_page": 10
    }
}
```


**Read specific message**

```
GET /applications/:application_token/chats/:chat_number/messages/:number
```

JSON example of the response

```json
{
    "message": {
        "body": "Hello",
        "message_number": 1
    }
}
```

**Update specific message**

```
PUT /applications/:application_token/chats/:chat_number/messages/:number
```

JSON example of request body

```json
{
  "message": {
    "body": "Hello my friend"
  }
}
```


**Search on specific chat**

**Note:** This endpoint used elasticsearch

```
GET /applications/:application_token/chats/:chat_number/messages
```

JSON example of request body
```json
{
    "query": "hello",
}
```

JSON example of the response body

```json
{
    "messages": [
        {
            "body": "Hello my friend",
            "message_number": 1
        }
    ],
    "meta": {
        "current_page": 1,
        "per_page": 10
    }
}
```
