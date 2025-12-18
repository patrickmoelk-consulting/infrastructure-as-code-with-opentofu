from sqlmodel import Field
from todos.db.base_class import Base


class Todo(Base, table=True):
    id: int = Field(default=None, primary_key=True, index=True)
    todo: str
    completed: bool