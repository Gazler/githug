(function() {
  if (window.location.search.match(/receiver/gi)) {
    return;
  }

  var socket = io.connect(window.location.origin),
      socketId = Math.random().toString().slice(15);

  console.log("View slide notes at " + window.location.origin + "/notes/" + socketId);

  window.open(window.location.origin + "/notes/" + socketId, "notes-" + socketId);

  function getNextSlideCoordinates(slide, actual) {
    var h = actual.indexH,
        v = actual.indexV;

    if (typeof(h) !== "number") {
      h = actual.indexh;
    }

    if (typeof(v) !== "number") {
      v = actual.indexv;
    }

    if (slide.nextElementSibling && slide.parentNode.nodeName == "SECTION") {
      nextIndexH = h;
      nextIndexV = v + 1;
    } else {
      nextIndexH = h + 1;
      nextIndexV = v;
    }

    return {
      H: nextIndexH,
      V: nextIndexV
    };
  }

  socket.on("nextSlide", function(data) {
    if (data.socketId === socketId) {
      Reveal.next();
    }
  });

  socket.on("prevSlide", function(data) {
    if (data.socketId === socketId) {
      Reveal.prev();
    }
  });

  socket.on("initialSlide", function(data) {
    var start = { indexH: 0, indexV: 0 },
        firstSlideData,
        notesElement,
        slide,
        next;

    if (data.socketId !== socketId) {
      return;
    }

    slide = Reveal.getCurrentSlide();
    notesElement = slide.querySelector("aside.notes");

    if (slide && notesElement) {
      next = getNextSlideCoordinates(slide, start);

      firstSlideData = {
        notes: notesElement.innerHTML,
        markdown: notesElement.getAttribute("data-markdown") === "string",

        indexH : start.indexH,
        indexV : start.indexV,

        nextIndexH: next.H,
        nextIndexV: next.V,

        socketId: socketId
      };

      socket.emit("initialSlideReceived", firstSlideData);
    }
  })

  Reveal.addEventListener("fragmentshown", function(event) {
    var fragmentData = {
      fragment : "next",
      socketId : socketId
    };

    socket.emit("fragmentChanged", fragmentData);
  });

  Reveal.addEventListener("fragmenthidden", function(event) {
    var fragmentData = {
      fragment : "previous",
      socketId : socketId
    };

    socket.emit("fragmentChanged", fragmentData);
  });

  Reveal.addEventListener("slidechanged", function(event) {
    var slideElement = event.currentSlide,
        notes = slideElement.querySelector("aside.notes"),

        slideData = {
          notes : notes ? notes.innerHTML : "",

          indexH : event.indexh,
          indexV : event.indexv,

          socketId : socketId,
          markdown : notes ? typeof(notes.getAttribute("data-markdown")) === "string" : false
        },

        next;

    next = getNextSlideCoordinates(slideElement, event);

    slideData.nextIndexH = next.H;
    slideData.nextIndexV = next.V;

    socket.emit("slideChanged", slideData);
  });
} ());