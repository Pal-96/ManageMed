document.addEventListener('DOMContentLoaded', function() {
	gsap.registerPlugin(ScrollTrigger);
	
		// Example animation for section 1
	gsap.from("#section1", {
		scrollTrigger: {
			trigger: "#section1",
			start: "top 80%",
			end: "bottom 100%"
		},
		y: 50,
		x: 50,
		opacity: 5,
		duration: 1
	});

	// Example animation for section 2
	gsap.from("#section2", {
		scrollTrigger: {
			trigger: "#section2",
			start: "top 80%",
			end: "bottom 20%"
		},
		x: -50,
		y: 100,
		opacity: 0,
		duration: 1
	});

	// Example animation for section 3
	gsap.from("#section3", {
		scrollTrigger: {
			trigger: "#section3",
			start: "top 80%",
			end: "bottom 20%"
		},
		x: -50,
		y:100,
		opacity: 0,
		duration: 1
	});
	
	gsap.from("#section4", {
		scrollTrigger: {
			trigger: "#section4",
			start: "top 80%",
			end: "bottom 100%"
		},
		y: 50,
		x: 50,
		opacity: 0,
		duration: 2
	});

	gsap.to("#activeusers", {
		rotation: 360,
		duration: 4
	});
	gsap.to("#totalsales", {
		rotation: -360,
		duration: 4
	});
	gsap.to("#products", {
		rotation: 360,
		duration: 3
	});

});