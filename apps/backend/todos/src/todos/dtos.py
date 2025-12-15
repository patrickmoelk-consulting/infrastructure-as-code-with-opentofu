from pydantic import BaseModel


class Todo(BaseModel):
    id: int
    todo: str
    completed: bool

    class Config:
        validate_by_name = True
        from_attributes = True


class CreateTodo(BaseModel):
    todo: str
    completed: bool


class UpdateTodo(CreateTodo):
    pass
