angular.module \myapp, <[ui.choices]>

myctrl = ($scope) ->
  $scope.transportation = []
  $scope.fruit = []
  $scope.fruit11multi = true
  $scope.fruit11 =
    multi: true
    value: {}
    data: [
      { name: "Banana", value: 1, fallback: true, btntype: 'btn-primary' },
      { name: "Graphfruit", value: 2 },
      { name: "Pitaya", value: 3, active: true }
    ]

  $scope.fruit12 = [
    {
      name: "breakfast?"
      multi: true
      value: {}
      data: [
        { name: "Banana", value: 1, fallback: true },
        { name: "Graphfruit", value: 2 },
        { name: "Pitaya", value: 3, active: true }
      ]
    },
    {
      name: "lunch?"
      multi: false
      value: {}
      data: [
        { name: "Apple", value: 1, fallback: true },
        { name: "Peach", value: 2 },
        { name: "Orange", value: 3 }
      ]
    },
    {
      name: "dinner?"
      multi: true
      value: {1: true, 2: true, 3:true }
      data: [
        { name: "Guava", value: 1 },
        { name: "Longan", value: 2 },
        { name: "Litchi", value: 3 }
      ]
    }
  ]
