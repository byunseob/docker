FROM python:3.7
ENV PYTHONUNBUFFERED=1

RUN apk add --update \
    && apk add --no-cache gcc libc-dev linux-headers \
    && pip install uwsgi \
    && pip install gunicorn


CMD ["python3"]
