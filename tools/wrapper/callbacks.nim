type
  GroupingCallback* = proc(objName, fieldName, fieldType,
                           prevFieldType: string): tuple[startGroup, endGroup: bool]

proc defaultGroupingCallback(objName, fieldName, fieldType,
                             prevFieldType: string): tuple[startGroup, endGroup: bool] =
  if objName == "Matrix":
    case fieldName
    of "m0", "m1", "m2", "m3":
      result = (true, true)
    of "m12", "m13", "m14", "m15":
      result = (false, false)
    else:
      result = (false, true)
  else:
    result = (true, false)

proc groupByTypeCallback(objName, fieldName, fieldType,
                         prevFieldType: string): tuple[startGroup, endGroup: bool] =
  if fieldType != prevFieldType:
    result = (true, true)
  else:
    result = (false, true)
