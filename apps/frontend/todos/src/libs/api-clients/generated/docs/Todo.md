
# Todo


## Properties

Name | Type
------------ | -------------
`id` | number
`todo` | string
`completed` | boolean

## Example

```typescript
import type { Todo } from ''

// TODO: Update the object below with actual values
const example = {
  "id": null,
  "todo": null,
  "completed": null,
} satisfies Todo

console.log(example)

// Convert the instance to a JSON string
const exampleJSON: string = JSON.stringify(example)
console.log(exampleJSON)

// Parse the JSON string back to an object
const exampleParsed = JSON.parse(exampleJSON) as Todo
console.log(exampleParsed)
```

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)


