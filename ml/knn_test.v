module ml

import vsl.la

fn test_knn_predict() {
	x := [
		[1.0, 0.0],
		[1.2, -0.3],
		[2.5, 0.0083],
		[9.45, 10.8],
		[10.0, 10],
		[9.03, 7.75],
	]
	y := [
		0.,
		0,
		0,
		1,
		1,
		1,
	]
	mut knn := new_knn(mut data_from_raw_xy_sep(x, y))
	assert knn.predict(k: 1, to_pred: [0.333333, 0.66666]) == 0.0
	assert knn.predict(k: 1, to_pred: [11., 9.3]) == 1.0
}

fn test_knn_predict_with_data_change() {
	mut x := [
		[1.0, 0.0],
		[1.2, -0.3],
		[2.5, 0.0083],
		[9.45, 10.8],
		[10.0, 10],
		[9.03, 7.75],
	]
	mut y := [
		0.,
		0,
		0,
		1,
		1,
		1,
	]
	mut data := data_from_raw_xy_sep(x, y)

	mut knn := new_knn(mut data)
	assert knn.predict(k: 1, to_pred: [0.333333, 0.66666]) == 0.0
	assert knn.predict(k: 1, to_pred: [11., 9.3]) == 1.0

	x << [1., 2.]
	y << 1

	m := la.matrix_deep2(x)
	data.set(m, y)

	assert knn.predict(k: 1, to_pred: [0.333333, 0.66666]) == 0.0
	assert knn.predict(k: 1, to_pred: [11., 9.3]) == 1.0
}

fn test_knn_predict_with_weights() {
	x := [
		[0.],
		[0.5],
		[9.7],
		[10.2],
		[-100.4],
		[-174.58883034],
		[9.85],
	]
	y := [
		1.,
		1,
		2,
		2,
		3,
		3,
		3,
	]
	mut w := map{
		1.: 1.
		2:  1
		3:  1
	}
	mut train_data := data_from_raw_xy_sep(x, y)
	mut knn := new_knn(mut train_data)
	knn.set_weights(w)
	assert knn.predict(k: 5, to_pred: [9.8]) == 2.

	w[3.] = 2.
	knn.set_weights(w)
	assert knn.predict(k: 5, to_pred: [9.8]) == 3.
}
