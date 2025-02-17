module main

import vsl.plot
import vsl.util

y := [
	0.0,
	1,
	3,
	1,
	0,
	-1,
	-3,
	-1,
	0,
	1,
	3,
	1,
	0,
]
x := util.arange(y.len).map(f64(it))

mut plt := plot.new_plot()
plt.add_trace(
	trace_type: .scatter
	x: x
	y: y
	mode: 'lines+markers'
	colorscale: 'smoker'
	marker: plot.Marker{
		size: []f64{len: x.len, init: 10.0}
	}
)
plt.set_layout(
	title: 'Scatter plot example'
)
plt.show()?
