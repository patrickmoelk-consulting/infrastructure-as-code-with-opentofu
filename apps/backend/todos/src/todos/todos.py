from typing import List
from fastapi import APIRouter, Depends
from sqlmodel import Session, select

from .dtos import CreateTodo, Todo, UpdateTodo
from . import dependencies as deps
from .db.model import Todo as DbTodo

router = APIRouter(tags=["TODOs"])


@router.get("", response_model=List[Todo])
def get_todos(db: Session = Depends(deps.db_session)) -> List[DbTodo]:
    # dummy1 = Todo(id=1, todo="dummy1", completed=False)
    # dummy2 = Todo(id=2, todo="dummy2", completed=True)

    query = select(DbTodo)
    return db.exec(query).all()

    return [dummy1, dummy2]


@router.post("")
def create_one(todo: CreateTodo, db: Session = Depends(deps.db_session)) -> str:
    db_todo = DbTodo(todo=todo.todo, completed=todo.completed)
    db.add(db_todo)
    db.commit()

    return "OK"


@router.patch("/{id}")
def update_one(id: int, todo: UpdateTodo, db: Session = Depends(deps.db_session)) -> str:
    query = select(DbTodo).where(DbTodo.id == id)
    db_todo = db.exec(query).one()
    db_todo.completed = todo.completed
    db_todo.todo = todo.todo
    db.commit()

    return "UPDATED"


@router.delete("/{id}")
def delete_one(id: int, db: Session = Depends(deps.db_session)) -> str:
    query = select(DbTodo).where(DbTodo.id == id)
    todo = db.exec(query).one()
    db.delete(todo)
    db.commit()

    return "DELETED"
