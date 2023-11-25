FROM node:21-alpine as build
COPY . .
RUN apk add --no-cache make
RUN npm i
RUN make bundle

FROM stoplight/prism:4.1.2
LABEL authors="sayyidyofa"

COPY --from=build ./specification ./prism
EXPOSE 4010

ENTRYPOINT ["mock", "-h", "0.0.0.0", "/prism/DigitalOcean-public.v2.yaml"]