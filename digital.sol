// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalIdentityManager {
    // Event to emit when a new identity is registered
    event IdentityRegistered(address indexed user, string username);

    // Event to emit when an identity is updated
    event IdentityUpdated(address indexed user, string newUsername);

    // Structure to hold digital identity details
    struct Identity {
        string username;
        bool isRegistered;
    }

    // Mapping to store user identities
    mapping(address => Identity) private identities;

    // Function to register a new digital identity
    function registerIdentity(string calldata _username) external {
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(!identities[msg.sender].isRegistered, "Identity already registered");

        // Register the identity
        identities[msg.sender] = Identity({
            username: _username,
            isRegistered: true
        });

        emit IdentityRegistered(msg.sender, _username);
    }

    // Function to update an existing digital identity
    function updateIdentity(string calldata _newUsername) external {
        require(bytes(_newUsername).length > 0, "New username cannot be empty");
        require(identities[msg.sender].isRegistered, "Identity not registered");

        // Update the identity
        identities[msg.sender].username = _newUsername;

        emit IdentityUpdated(msg.sender, _newUsername);
    }

    // Function to get the digital identity of a user
    function getIdentity(address _user) external view returns (string memory username, bool isRegistered) {
        Identity memory identity = identities[_user];
        return (identity.username, identity.isRegistered);
    }
}
