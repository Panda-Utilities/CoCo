--!nocheck
--!nolint

--[[
    @link https://github.com/Panda-Utilities/CoCo/
    @author @panduhpanduhpanduhpanduh on Discord
    @repository CoCo
    @license GPL-3.0 with additional terms

    Copyright © 2026 CoCo, GPL-3.0 license with additional terms.
    This file was automatically generated with darklua, it is not intended for manual editing.
--]]

if getgenv().CoCo then return end
getgenv().CoCo = true

_P = {
    genDate = __COMPOSER.Insert(__COMPOSER.genDate),
    cfg = __COMPOSER.Insert(__COMPOSER.cfg),
    vers = __COMPOSER.Insert(__COMPOSER.vers)
}

__COMPOSER.Insert(__COMPOSER.build)
