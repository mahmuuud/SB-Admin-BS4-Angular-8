FROM node
WORKDIR SB-Admin-BS4-Angular-8
COPY . .
RUN apt-get update -y
RUN apt-get install -y default-jre
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update -qqy \
	&& apt-get -qqy install google-chrome-stable \
	&& rm /etc/apt/sources.list.d/google-chrome.list \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& sed -i 's/"$HERE\/chrome"/"$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome
RUN ./node_modules/.bin/webdriver-manager update --versions.chrome ${chrome_version}
RUN npm install
RUN npm install -g webdriver-manager
CMD ["webdriver-manager", "update"]
CMD ["webdriver-manager", "start"]
# CMD npm start
