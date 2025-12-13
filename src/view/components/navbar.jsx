import React from 'react';
import { Dropdown } from 'react-bootstrap';

export default function Navbar() {
  return (
    <nav className="navbar navbar-dark bg-dark justify-content-between px-3">
      <input className="form-control w-50" type="search" placeholder="Search" />
      <Dropdown>
        <Dropdown.Toggle variant="secondary" id="dropdown-basic">
          Admin
        </Dropdown.Toggle>
        <Dropdown.Menu>
          <Dropdown.Item href="#/action-1">Profil</Dropdown.Item>
          <Dropdown.Item href="#/action-2">Logout</Dropdown.Item>
        </Dropdown.Menu>
      </Dropdown>
    </nav>
  );
}

