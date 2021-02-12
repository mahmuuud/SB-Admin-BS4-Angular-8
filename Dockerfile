FROM node
WORKDIR SB-Admin-BS4-Angular-8
COPY . .
RUN npm install
CMD ["npm", "start"] # ng serve --host 0.0.0.0
