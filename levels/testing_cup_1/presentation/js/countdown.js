(function (window, document) {
  var defaults = {
        eventPrefix: "timer:"
      },

      // Dividers for time units
      day = 86400000,
      hour = 3600000,
      minute = 60000,
      second = 1000,

      getEvent;

  /*
    Non-mutating object extension.
  */
  function extend(dest, src) {
    var result = JSON.parse(JSON.stringify(dest));

    for (var prop in src) {
      if (prop in src && !(prop in dest)) {
        result[prop] = src[prop];
      }
    }

    return result;
  }

  /*
    IE9 fallback, just in case.
  */
  (function initalizeGetEvent(window) {
    if ("CustomEvent" in window && typeof CustomEvent === "function") {
      getEvent = function(type, detail) {
        return new window.CustomEvent(type, {
          detail: detail,
          bubbles: true,
          cancelable: true
        });
      };
    } else if ("createEvent" in document) {
      getEvent = function(type, detail) {
        var evt = document.createEvent("HTMLEvents");

        evt.initEvent(type, true, true);
        evt.data = detail;

        return evt;
      };
    } else {
      throw new Error("Supposed to be tested in latest browser.");
    }
  } (window));

  /*
    Creates an object containing number of days, hours, minutes and seconds left until given due date.
    If no due date is passed in, instance"s preset date is taken as the default.
  */
  function getTimeLeft(dueDate) {
    var timeSpan = (dueDate || this.options.dueDate) - new Date(),
        result = {};

    result.days = Math.floor((timeSpan / day));
    result.hours = Math.floor(((timeSpan % day) / hour));
    result.minutes = Math.floor(((timeSpan % day % hour) / minute));

    // A bit ugly but better accuracy than Math.floor(((timeSpan % day % hour % minute) / second)).
    result.seconds = Math.round(((timeSpan % day % hour % minute) / second)) % 61 - 1;

    if (result.seconds < 0) {
      result.seconds = 0;
    }

    return result;
  }

  /*
    Shallow type-checking. Determines whether an element"s type string contains a given type name.
  */
  function isTypeOf(typeName) {
    return Object.prototype.toString.call(this).indexOf(typeName) !== -1;
  }

  /*
    Checks whether an options parameter object contains given parameter.
    This function requires passing explicit context through call or apply.
  */
  function check(paramName) {
    if (!this.hasOwnProperty(paramName)) {
      throw new Error(["A \"", paramName, "\" parameter is required."].join());
    }
  }

  /*
     Gets a prefixed version of the given event name.
     The prefixes are determined by the instance"s options.
  */
  function prefixedEventName(eventName) {
    return (eventName.indexOf(this.options.eventPrefix) === -1 ?
            [this.options.eventPrefix, eventName].join("") : eventName);
  }

  /*
     Attaches a callback to a given event.
  */
  function on(eventName, callback) {
    this.options.DOMScope.addEventListener(prefixedEventName.call(this, eventName), callback);
  }

  /*
    Triggers an event for this instance"s DOM scope.
  */
  function trigger(eventName, eventData) {
    this.options.DOMScope.dispatchEvent(getEvent(prefixedEventName.call(this, eventName), eventData));
  }

  var Countdown = function(options) {
    var self = this,
        trg = trigger;

    check.call(options, "dueDate");

    if (!isTypeOf.call(options.dueDate, "Date")) {
      throw new TypeError("dueDate must be a valid Date.");
    }

    this.options = extend(defaults, options);

    /*
      Starts the countdown - tick events are being thrown every second until the due date.
    */
    this.start = function () {
      var timeLeft = self.getTimeLeft();

      if (self.options.dueDate - new Date() < 1000) {
        trg.call(self, "due", timeLeft);
      } else {
        trg.call(self, "tick", timeLeft);
        setTimeout(self.start.bind(self), 1000);
      }
    };

    return this;
  };

  Countdown.prototype = {
    getTimeLeft: getTimeLeft,
    on: on
  };

  window.Countdown = Countdown;

  function $$(selector, parent) {
    return [].slice.call(parent.querySelectorAll(selector), 0);
  }

  /*
    Pads given value with zeroes up to specified size (i.e. string length).
  */
  function zeroPad(value, size) {
    var n = Math.abs(value);
    var zeros = Math.max(0, size - Math.floor(n).toString().length);
    var zeroString = Math.pow(10, zeros).toString().substr(1);
    if (value < 0) {
      zeroString = "-" + zeroString;
    }

    return zeroString + n;
  }

  /*
    Inputs numeric data into an element.
  */
  function inputNumericData(el, dataSource) {
    el.textContent = zeroPad(dataSource[el.className], 2);
  }

  /*
    Displays given time within the UI.
  */
  function displayTime(color, e) {
    var time = e.detail || e.data;

    $$(".hours,.minutes,.seconds", this.options.DOMScope).forEach(function(e) {
      inputNumericData(e, time);

      if (color === "red") {
        e.parentNode.style.color = color;
        e.style.color = color;
      } else {
        e.style.color = color;
      }
    });
  }

  window.createTimer = function (ui, amount) {
    return function () {
      var timer = new Countdown({
        dueDate: new Date(new Date().getTime() + amount),
        DOMScope: ui
      });

      timer.on("tick", window.CountdownNamespace.displayTime.bind(timer, "black"));
      timer.on("due", window.CountdownNamespace.displayTime.bind(timer, "red"));

      timer.start();
    };
  };

  window.seconds = function (value) {
    return value * 1000;
  };

  window.minutes = function (value) {
    return value * 60 * 1000;
  };

  window.CountdownNamespace = {};
  window.CountdownNamespace.displayTime = displayTime;

} (window, window.document));