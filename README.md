# Zee Api

[![CircleCI](https://circleci.com/gh/rodmba/zee_api.svg?style=svg)](https://circleci.com/gh/rodmba/zee_api)

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/12c689c85fa743c5a19e69df5ab9224e)](https://www.codacy.com/app/rodmba/zee_api?utm_source=github.com&utm_medium=referral&utm_content=rodmba/zee_api&utm_campaign=Badge_Grade)

Zee api is a REST API which consumes Github API and uses JWT as authentication.

-   [Ruby on Rails][rails]
-   [PostgreSQL][postgres]
-   [Docker][docker]
-   [JWT][jwt]

## Development

### Setup

Development happens on your local machine. We only use [Docker][docker] to provide database.

If you're using Ubuntu, run the bootstrap script to put most dependencies in place:

     $ scripts/bootstrap

This will install everything you require to compile gems and run the pre-configured Docker containers.

To actually get stuff done, install Ruby dependencies:

    $ bundle install

, and run the containers:

    $ docker-compose up

If you don't care about the wall of text it spits out, use `docker-compose up -d`.

## API Documentation

### Sign up and Authentication

To sign up in the application use the endpoint below:

```http
POST https://rodmba-zee-api.herokuapp.com/api/v1/users
```

and pass the user credentials for registration like:

```json
{ "user": {"email": "person@example.com", "password": "12345678", "password_confirmation": "12345678" } }
```

If you sign up correctly you will receive the response:

```json
{ "status": "User created successfully" }
```

To sign in the application use the endpoint below:

```http
POST https://rodmba-zee-api.herokuapp.com/api/v1/users/sign_in
```

and pass the user credentials like:

```json
{ "email": "person@example.com", "password": "12345678" }
```

If you sign in correctly you will receive the response:

```json
{
    "auth_token": "some-token-to-sign-in"
}
```

After that, in every request you need to use your token inside header:

```json
Authorization: Bearer your-token-here
```

### Endpoints

Listing of all GitHub public repositories:

```http
GET https://rodmba-zee-api.herokuapp.com/api/v1/git_hub/repositories
```

Search repositories by a keyword or language:

```http
GET https://rodmba-zee-api.herokuapp.com/api/v1/git_hub/repository_by_keyword
```

| Parameter  | Type     | Description                                                                   |
| :--------- | :------- | :---------------------------------------------------------------------------- |
| `keyword`  | `string` | You can search repositories by a keyword.                                     |
| `language` | `string` | You can pass a language to search. If no language is passed, ruby is default. |
| `sort`     | `string` | You can sort the result by `stars`, `forks` or `updated`.                     |
| `order`    | `string` | You can order `asc`, default is `desc`.                                       |

Search user repositories:

```http
GET https://rodmba-zee-api.herokuapp.com/api/v1/git_hub/repository_by_user
```

| Parameter | Type     | Description                                               |
| :-------- | :------- | :-------------------------------------------------------- |
| `user`    | `string` | You can search user repositories.                         |
| `sort`    | `string` | You can sort the result by `stars`, `forks` or `updated`. |
| `order`   | `string` | You can order `asc`, default is `desc`.                   |

[postgres]: https://www.postgresql.org/

[rails]: https://rubyonrails.org/

[jwt]: https://jwt.io/

[docker]: https://www.docker.com/
