FROM ykorzikowski/backup-pgsql

ENV S3='s3://mybucket/'
ENV PGHOST='localhost:5432'
ENV PGDATABASE='postgres'
ENV PGUSER='postgres@postgres'
ENV PGPASSWORD='password'

ENV AWSCLI_VERSION "1.14.10"

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    && pip install awscli==$AWSCLI_VERSION --upgrade\
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

COPY ./dumpAndCopy.sh .

RUN chmod 755 dumpAndCopy.sh

CMD [ "./dumpAndCopy.sh" ]
