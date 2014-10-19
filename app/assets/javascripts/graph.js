var width = $("#dependencies").width();
var height = width * 3.0 / 4.0;

var color = d3.scale.linear();

var force = d3.layout.force()
  .size([width, height]);

var svg = d3.select("#dependencies").append("svg")
  .attr("width", width)
  .attr("height", height);

var nodes = [
    { "name": "Expressions", "fixed": true, "x": width / 2, "y": height / 10 },
    { "name": "Compound Interest Calculator" },
    { "name": "Data Types" },
    { "name": "Rock, Paper, Scissors" }
];

var links = [
    { "source": 0,"target": 1 },
    { "source": 1,"target": 2 },
    { "source": 2,"target": 3 }
];

force.nodes(nodes)
  .links(links)
  .start();

var link = svg.selectAll(".link")
  .data(links)
  .enter().append("line")
  .attr("class", "link")
  .style("stroke-width", function(d) { return Math.sqrt(d.value); });

var node = svg.selectAll(".node")
  .data(nodes)
  .enter().append("circle")
  .attr("r", 10)
  .attr("class", "node");

node.append("title").text(function(d) { return d.name; });

node.on("click", function(d) {
  alert(d.name);
});

force.on("tick", function() {
  link.attr("x1", function(d) { return d.source.x; })
    .attr("y1", function(d) { return d.source.y; })
    .attr("x2", function(d) { return d.target.x; })
    .attr("y2", function(d) { return d.target.y; });

  node.attr("cx", function(d) { return d.x; })
    .attr("cy", function(d) { return d.y; });
});
