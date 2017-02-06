--!The Make-like Build Utility based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2017, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        xmake.lua
--

-- define language
language("swift")

    -- set source file kinds
    set_sourcekinds {sc = ".swift"}

    -- set source file flags
    set_sourceflags {sc = "scflags"}

    -- set target kinds
    set_targetkinds {binary = "ld", static = "ar", shared = "sh"}

    -- set target flags
    set_targetflags {binary = "ldflags", static = "arflags", shared = "shflags"}

    -- on load
    on_load("load")

    -- set name flags
    set_nameflags 
    {
        compiler =
        {
            "config.includedirs"
        ,   "target.symbols"
        ,   "target.warnings"
        ,   "target.optimize:check"
        ,   "target.vectorexts:check"
        ,   "target.languages"
        ,   "target.includedirs"
        ,   "target.defines"
        ,   "target.undefines"
        ,   "option.symbols"
        ,   "option.warnings"
        ,   "option.optimize:check"
        ,   "option.vectorexts:check"
        ,   "option.languages"
        ,   "option.includedirs"
        ,   "option.defines"
        ,   "option.undefines"
        ,   "option.defines_if_ok"
        ,   "option.undefines_if_ok"
        ,   "platform.includedirs"
        ,   "platform.defines"
        ,   "platform.undefines"
        }
    ,   linker =
        {
            "config.linkdirs"
        ,   "target.linkdirs"
        ,   "target.strip"
        ,   "target.symbols"
        ,   "option.strip"
        ,   "option.symbols"
        ,   "option.linkdirs"
        ,   "platform.linkdirs"
        ,   "config.links"
        ,   "target.links"
        ,   "option.links"
        ,   "platform.links"
        }
    ,   archiver = 
        {
            "target.strip"
        ,   "target.symbols"
        }
    }

    -- set menu
    set_menu {
                config = 
                {   
                    {}
                ,   {nil, "sc",         "kv", nil,          "The Swift Compiler"                    }
                ,   {nil, "scflags",    "kv", nil,          "The Swift Compiler Flags"              }

                ,   {}
                ,   {nil, "ld",         "kv", nil,          "The Linker"                            }
                ,   {nil, "ldflags",    "kv", nil,          "The Binary Linker Flags"               }

                ,   {}
                ,   {nil, "ar",         "kv", nil,          "The Static Library Linker"             }
                ,   {nil, "arflags",    "kv", nil,          "The Static Library Linker Flags"       }

                ,   {}
                ,   {nil, "sh",         "kv", nil,          "The Shared Library Linker"             }
                ,   {nil, "shflags",    "kv", nil,          "The Shared Library Linker Flags"       }

                ,   {}
                ,   {nil, "links",      "kv", nil,          "The Link Libraries"                    }
                ,   {nil, "linkdirs",   "kv", nil,          "The Link Search Directories"           }
                ,   {nil, "includedirs","kv", nil,          "The Include Search Directories"        }
                }
            } 




