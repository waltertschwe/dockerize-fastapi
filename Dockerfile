FROM python:3.10

RUN mkdir /app

WORKDIR /app

RUN pip3 install poetry

COPY /pyproject.toml /poetry.lock* /app/

ENV PATH /home/${USERNAME}/.local/bin:${PATH}

ARG INSTALL_DEV=true
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY . .

CMD ["poetry", "run", "uvicorn", "main:app", "--host=0.0.0.0", "--reload" , "--port=80", "log_level=info"]