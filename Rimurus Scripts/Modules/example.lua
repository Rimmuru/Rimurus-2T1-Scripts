local testParent = func.add_feature("example module", "parent", 0)

func.add_feature("example module", "parent", testParent.id, function()
    func.notification("test")
end)