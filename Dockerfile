FROM python

LABEL maintainer="https://annict.com/@shimbaco" \
      description="A dashboard of Annict."

ARG DENO_VERSION=v0.2.7
RUN curl -L https://deno.land/x/install/install.py | python - ${DENO_VERSION}
ENV PATH="/root/.deno/bin:$PATH"

WORKDIR /annict-dashboard/
COPY . /annict-dashboard/

CMD deno --allow-net /annict-dashboard/server.ts -p $PORT
