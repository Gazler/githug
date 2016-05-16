(function() {
    var DISTANCE = 20;

    var SVG = "<svg width='100%' height='500' viewBox='0 0 1030 1050'" +
                 "width='1030' height='1050'" +
                 "xmlns='http://www.w3.org/2000/svg'" +
                 "xmlns:svg='http://www.w3.org/2000/svg'>" +
              "<!-- Created with SVG-edit - http://svg-edit.googlecode.com/ -->" +
              "<style type='text/css' >" +
                "<![CDATA[" +
                  "polygon {" +
                      "stroke: #666;" +
                      "stroke-width: 4px;" +
                      "fill: #fff;" +
                  "}" +
                  ".active {" +
                      "fill: #7FDBFF;" +
                  "}" +
                  "text {" +
                    "font-family: monospace;" +
                  "}" +
                "]]>" +
              "</style>" +
              "<g>" +
                "<title>Pyramid</title>" +
                "<polygon points='410,220 610,220 510,20'/>" +
                "<polygon points='310,420 710,420 610,220 410,220'/>" +
                "<polygon points='210,620 810,620 710,420 310,420'/>" +
                "<polygon points='110,820 910,820 810,620 210,620'/>" +
                "<polygon points='10,1020 1010,1020 910,820 110,820'/>" +
              "</g>" +
              "<g>" +
                "<title>Text</title>" +
                "<text x='477' y='170' font-size='55' fill='black'>" +
                  "<tspan>" +
                    "UI" +
                  "</tspan>" +
                "</text>" +
                "<text x='390' y='335' font-size='45' fill='black'>" +
                  "<tspan>" +
                    "Systemowe" +
                  "</tspan>" +
                "</text>" +
                "<text x='345' y='475' font-size='45' fill='black'>" +
                  "<tspan>" +
                    "Integracyjne" +
                  "</tspan>" +
                  "<tspan dx='-320' dy='65'>" +
                    "Akceptacyjne" +
                  "</tspan>" +
                  "<tspan dx='-215' dy='55' font-size='35'>" +
                    "(BDD)" +
                  "</tspan>" +
                "</text>" +
                "<text x='380' y='690' font-size='55' fill='black'>" +
                  "<tspan>" +
                    "Domenowe" +
                  "</tspan>" +
                  "<tspan dx='-415' dy='65'>" +
                    "Logiki biznesowej" +
                  "</tspan>" +
                  "<tspan dx='-330' dy='45' font-size='35'>" +
                    "(BDD)" +
                  "</tspan>" +
                "</text>" +
                "<text x='335' y='900' font-size='55' fill='black'>" +
                  "<tspan>Jednostkowe</tspan>" +
                  "<tspan dx='-270' dy='65'>" +
                    "(TDD)" +
                  "</tspan>" +
                "</text>" +
              "</g>" +
            "</svg>";

    function noop() {}

    function translateY(dY) {
        return function addTransform(element) {
            element.setAttribute("transform", "translate(0, :dY)".replace(":dY", dY));
        };
    }

    function forEach(elements, fn) {
        for (var i = 0, l = elements.length; i < l; ++i) {
            fn(elements.item(i), i);
        }
    }

    var moveUp = translateY(-DISTANCE);
    var moveDown = translateY(DISTANCE);

    function moveElements(elements, pivotIndex) {
        var movingDown = false;
        var pivot = pivotIndex;
        var checkActive = typeof pivot === "undefined" ? function(element) {
                if (element.classList.contains("active")) {
                    movingDown = true;
                    checkActive = noop;
                    return true;
                }

                return false;
            } : noop;

        for (var i = 0, item;
            (item = elements.item(i)); ++i) {
            if (checkActive(item)) {
                pivot = i;
                continue;
            }

            if (i === pivot) {
                movingDown = true;
                continue;
            }

            (movingDown ? moveDown : moveUp)(item);
        }

        return pivot;
    }

    window.document.querySelector(".reveal").addEventListener("slidechanged", function(state) {
        if (state.currentSlide.getAttribute("data-pyramid") === "true") {
            state.currentSlide.querySelector(".svg-placeholder").innerHTML = SVG;
        }

        forEach(state.currentSlide.querySelectorAll("svg"), function(svg) {
            var active = parseInt(state.currentSlide.getAttribute("data-pyramid-active"), 10),
                pivot;

            if (!isNaN(active)) {
                svg.querySelectorAll("polygon")[active].classList.add("active");
            }

            pivot = moveElements(svg.querySelectorAll("polygon"));

            moveElements(svg.querySelectorAll("text"), pivot);
        });
    });

})();