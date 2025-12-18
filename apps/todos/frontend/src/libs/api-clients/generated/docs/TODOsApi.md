# TODOsApi

All URIs are relative to */api*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createOneTodosPost**](TODOsApi.md#createonetodospost) | **POST** /todos | Create One |
| [**deleteOneTodosIdDelete**](TODOsApi.md#deleteonetodosiddelete) | **DELETE** /todos/{id} | Delete One |
| [**getTodosTodosGet**](TODOsApi.md#gettodostodosget) | **GET** /todos | Get Todos |
| [**updateOneTodosIdPatch**](TODOsApi.md#updateonetodosidpatch) | **PATCH** /todos/{id} | Update One |



## createOneTodosPost

> string createOneTodosPost(createTodo)

Create One

### Example

```ts
import {
  Configuration,
  TODOsApi,
} from '';
import type { CreateOneTodosPostRequest } from '';

async function example() {
  console.log("🚀 Testing  SDK...");
  const api = new TODOsApi();

  const body = {
    // CreateTodo
    createTodo: ...,
  } satisfies CreateOneTodosPostRequest;

  try {
    const data = await api.createOneTodosPost(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **createTodo** | [CreateTodo](CreateTodo.md) |  | |

### Return type

**string**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Successful Response |  -  |
| **422** | Validation Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## deleteOneTodosIdDelete

> string deleteOneTodosIdDelete(id)

Delete One

### Example

```ts
import {
  Configuration,
  TODOsApi,
} from '';
import type { DeleteOneTodosIdDeleteRequest } from '';

async function example() {
  console.log("🚀 Testing  SDK...");
  const api = new TODOsApi();

  const body = {
    // number
    id: 56,
  } satisfies DeleteOneTodosIdDeleteRequest;

  try {
    const data = await api.deleteOneTodosIdDelete(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **id** | `number` |  | [Defaults to `undefined`] |

### Return type

**string**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Successful Response |  -  |
| **422** | Validation Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## getTodosTodosGet

> Array&lt;Todo&gt; getTodosTodosGet()

Get Todos

### Example

```ts
import {
  Configuration,
  TODOsApi,
} from '';
import type { GetTodosTodosGetRequest } from '';

async function example() {
  console.log("🚀 Testing  SDK...");
  const api = new TODOsApi();

  try {
    const data = await api.getTodosTodosGet();
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Array&lt;Todo&gt;**](Todo.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Successful Response |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


## updateOneTodosIdPatch

> string updateOneTodosIdPatch(id, updateTodo)

Update One

### Example

```ts
import {
  Configuration,
  TODOsApi,
} from '';
import type { UpdateOneTodosIdPatchRequest } from '';

async function example() {
  console.log("🚀 Testing  SDK...");
  const api = new TODOsApi();

  const body = {
    // number
    id: 56,
    // UpdateTodo
    updateTodo: ...,
  } satisfies UpdateOneTodosIdPatchRequest;

  try {
    const data = await api.updateOneTodosIdPatch(body);
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the test
example().catch(console.error);
```

### Parameters


| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **id** | `number` |  | [Defaults to `undefined`] |
| **updateTodo** | [UpdateTodo](UpdateTodo.md) |  | |

### Return type

**string**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: `application/json`
- **Accept**: `application/json`


### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Successful Response |  -  |
| **422** | Validation Error |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

