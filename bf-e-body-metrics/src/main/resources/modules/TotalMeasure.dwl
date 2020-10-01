%dw 2.0
fun totalMeasureValue(value, key) = value filter($.measureType == key) map((item, index) ->
	item.measureValue
)

