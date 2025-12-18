from typing import Generator

from sqlmodel import Session

from .db.session import engine


def db_session() -> Generator:
    try:
        _db = Session(engine)
        yield _db
    finally:
        _db.close()
