FROM node:21-alpine as build
COPY . .
RUN apk add --no-cache make
RUN make bundle

FROM stoplight/prism:4.1.2
LABEL authors="sayyidyofa"

COPY --from=build ./specification ./prism
EXPOSE 4010

CMD ["prism", "mock", "-h", "0.0.0.0", "/prism/DigitalOcean-public.v2.yaml"]