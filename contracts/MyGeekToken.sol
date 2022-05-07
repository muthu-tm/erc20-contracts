// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyGeekToken is ERC20, AccessControl {
    // Create a new role identifier for the minter role
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    // Create a new role identifier for the burner role
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(
        uint256 initialSupply,
        address minter,
        address burner
    ) public ERC20("MyGeekToken", "MGT") {
        // Grant the minter role to a specified account
        _setupRole(MINTER_ROLE, minter);
        // Grant the burner role to a specified account
        _setupRole(BURNER_ROLE, burner);

        // Grant the contract deployer the default admin role: it will be able
        // to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

        _mint(msg.sender, initialSupply);
    }

    function decimals() public virtual override view returns (uint8) {
        return 5;
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }
}
