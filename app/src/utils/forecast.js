const request = require("request");

const forecast = (latitude, longtitude, callback) => {
  const url =
    "https://api.darksky.net/forecast/48a1ebdacea0e2561551ee85c0773faa/" +
    encodeURIComponent(latitude) +
    "," +
    encodeURIComponent(longtitude) +
    "?units=ca";

  request({ url, json: true }, (error, { body }) => {
    if (error) {
      callback("Unable to connect to weather service!", undefined);
    } else if (body.error) {
      callback("Unable to find location", undefined);
    } else {
      callback(
        undefined,
        body.daily.data[0].summary +
          " It is currently " +
          body.currently.temperature +
          " degrees out. The height today is " +
          body.daily.data[0].temperatureHigh +
          " degrees and the low today is " +
          body.daily.data[0].temperatureLow +
          " degrees. There is a " +
          body.currently.precipProbability +
          "% chance of rain." +
          "The humidity is " +
          body.currently.humidity +
          "."
      );
    }
  });
};

module.exports = forecast;
