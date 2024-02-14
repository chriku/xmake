--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Copyright (C) 2015-present, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        select_script.lua
--

-- match pattern, plat|arch
function _match_pattern(pattern, plat, arch)
    return (plat .. '|' .. arch):match('^' .. pattern .. '$') or plat:match('^' .. pattern .. '$')
end

-- match patterns
function _match_patterns(patterns, plat, arch)
    for _, pattern in ipairs(patterns) do
        if _match_pattern(pattern, plat, arch) then
            return true
        end
    end
end

-- mattch the script pattern
--
-- the supported pattern:
--  plat|arch@subhost|subarch
--
-- e.g.
-- `@linux`
-- `@linux|x86_64`
-- `@macosx,linux`
-- `android@macosx,linux`
-- `android|armeabi-v7a@macosx,linux`
-- `android|armeabi-v7a,iphoneos@macosx,linux|x86_64`
-- `android|armeabi-v7a@linux|x86_64`
-- 'linux|.*'
--
function _match_script(pattern, plat, arch)
    local splitinfo = pattern:split("@", {plain = true})
    local plat_part = splitinfo[1]
    local host_part = splitinfo[2]
    local plat_patterns = plat_part:split(",", {plain = true})
    local host_patterns
    if host_part then
        host_patterns = host_part:split(",", {plain = true})
    end
    if _match_patterns(plat_patterns, plat, arch) then
        if host_patterns and #host_patterns > 0 and
            not _match_patterns(host_patterns, os.subhost(), os.subarch()) then
            return false
        end
        return true
    end
end

-- select the matched pattern script for the current platform/architecture
function select_script(scripts, opt)
    opt = opt or {}
    local result = nil
    if type(scripts) == "function" then
        result = scripts
    elseif type(scripts) == "table" then
        local plat = opt.plat or ""
        local arch = opt.arch or ""
        local script_matched
        for pattern, script in pairs(scripts) do
            if not pattern:startswith("__") and _match_script(pattern, plat, arch) then
                script_matched = script
                break
            end
        end
        result = script_matched or scripts["__generic__"]
    end
    return result
end

return select_script
