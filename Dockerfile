FROM python:3.8-alpine

# Install MariaDB dependencies
RUN apk add --no-cache mariadb-dev build-base pkgconf

# Install application requirements
COPY requirements.txt /flask-crud/requirements.txt 
WORKDIR /flask-crud
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Copy application files
COPY . /flask-crud

# Set environment variables
ENV MYSQL_USER jino
ENV MYSQL_PASSWORD secret
ENV MYSQL_DB student
ENV MYSQL_HOST 104.154.255.188
ENV MYSQL_PORT 3306
ENV MYSQLCLIENT_CFLAGS "-I/usr/include/mariadb"
ENV MYSQLCLIENT_LDFLAGS "-L/usr/lib/"

# Expose port 8080
EXPOSE 8080

# Use gunicorn as the WSGI server
ENTRYPOINT ["gunicorn", "--workers=3", "--bind=0.0.0.0:8080", "app:app"]