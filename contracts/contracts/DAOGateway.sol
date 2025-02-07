// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract DAOGateway {
    struct Document {
        string contents;
        uint[] references;
    }

    address dao;

    Document[] documents;

    constructor() {
        dao = msg.sender;
    }

    function publishDocument(Document calldata doc, uint parentIndex) external {
        require(msg.sender == dao, "Only the DAO contract can publish new documents.");
        documents.push(doc);
        documents[parentIndex].references.push(documents.length - 1);
    }

    function linkDocument(uint childIndex, uint parentIndex) external {
        require(msg.sender == dao, "Only the DAO contract can publish new documents.");
        documents[parentIndex].references.push(childIndex);
    }

    function readDocument(uint index) external view returns (string memory text) {
        text = documents[index].contents;
    }

    function getReferences(uint index) external view returns (uint[] memory refs) {
        refs = documents[index].references;
    }
}
