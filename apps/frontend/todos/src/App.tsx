import { TrashIcon } from "@heroicons/react/24/outline";
import { useEffect, useState, type FormEventHandler } from "react";
import "./App.css";
import { TODOsApi, type Todo } from "./libs/api-clients/generated";

function App() {
  return <TodoList />;
}

function useTodos(): [Todo[], (todos: Todo[]) => void] {
  const [todos, setTodos] = useState<Todo[]>([]);

  function setTodosOrdered(todos: Todo[]): void {
    const ordered = todos.sort((a, b) => a.id - b.id);
    setTodos(ordered);
  }

  return [todos, setTodosOrdered];
}

function TodoList() {
  const [todos, setTodos] = useTodos();

  async function fetchTodos() {
    const api = new TODOsApi();
    return api.getTodosTodosGet();
  }

  useEffect(() => {
    async function fetchAndSetTodos() {
      const todos = await fetchTodos();
      setTodos(todos);
    }

    fetchAndSetTodos();
  }, []);

  async function addTodo(todo: string): Promise<void> {
    if (!todo) return;

    const api = new TODOsApi();
    await api.createOneTodosPost({ createTodo: { todo, completed: false } });

    const todos = await fetchTodos();
    setTodos(todos);
  }

  async function deleteTodo(id: number): Promise<void> {
    const api = new TODOsApi();
    await api.deleteOneTodosIdDelete({ id });

    const todos = await fetchTodos();
    setTodos(todos);
  }

  async function updateTodo(todo: Todo): Promise<void> {
    const api = new TODOsApi();
    await api.updateOneTodosIdPatch({ id: todo.id, updateTodo: todo });

    const todos = await fetchTodos();
    setTodos(todos);
  }

  return (
    <div className="todo-list">
      <h2>TODO List</h2>
      <ul>
        {todos.map((todo) => (
          <TodoItem
            key={todo.id}
            todo={todo}
            onDelete={deleteTodo}
            onUpdate={updateTodo}
          />
        ))}
        <li>
          <NewTodo submitTodo={addTodo} />
        </li>
      </ul>
    </div>
  );
}

type TodoItemProps = {
  todo: Todo;
  onDelete: (id: Todo["id"]) => Promise<void>;
  onUpdate: (todo: Todo) => Promise<void>;
};

function TodoItem({ todo, onDelete, onUpdate }: TodoItemProps) {
  return (
    <li key={todo.id}>
      <span>
        <input
          id={`todo-${todo.id}`}
          type="checkbox"
          defaultChecked={todo.completed}
          onChange={(e) =>
            onUpdate({ ...todo, completed: e.currentTarget.checked })
          }
        />{" "}
        <label htmlFor={`todo-${todo.id}`}>{todo.todo}</label>
      </span>
      <button className="trash" onClick={() => onDelete(todo.id)}>
        <TrashIcon color="red" width={24} />
      </button>
    </li>
  );
}

type NewTodoProps = {
  submitTodo: (todo: string) => Promise<void>;
};

function NewTodo({ submitTodo }: NewTodoProps) {
  const onSubmit: FormEventHandler<HTMLFormElement> = async (e) => {
    e.preventDefault();
    const todo = e.currentTarget["todo"].value;
    if (!todo) return;

    submitTodo(todo);

    e.currentTarget["todo"].value = "";
  };

  return (
    <form onSubmit={onSubmit}>
      <input
        type="text"
        name="todo"
        placeholder="new todo"
        autoComplete="off"
        onSubmit={(e) => {
          e.currentTarget.value = "";
        }}
      />
    </form>
  );
}

export default App;
