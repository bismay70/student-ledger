// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract StudentRegistry {

    struct Student {
        string name;
        uint256 rollNumber;
        address wallet;
        bool isRegistered;
    }

    mapping(address => Student) private students;

    event StudentRegistered(
        address indexed wallet,
        string name,
        uint256 rollNumber
    );

    function registerStudent(string memory _name, uint256 _rollNumber) public {
        require(!students[msg.sender].isRegistered, "Already registered");
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(_rollNumber > 0, "Roll number must be greater than 0");

        students[msg.sender] = Student(
            _name,
            _rollNumber,
            msg.sender,
            true
        );

        emit StudentRegistered(msg.sender, _name, _rollNumber);
    }

    function getStudent(address _studentAddress)
        public
        view
        returns (string memory, uint256, address)
    {
        require(students[_studentAddress].isRegistered, "Student not found");

        Student memory student = students[_studentAddress];

        return (
            student.name,
            student.rollNumber,
            student.wallet
        );
    }
}
