import React from 'react'
import { useState, useEffect } from "react";
import { Button, Form } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import Swal from 'sweetalert2';
export default function Register() {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [data, setData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const history = useNavigate();
    useEffect(() => {
        if (sessionStorage.getItem("access_token") !== null) {
            history('/Register')
        }
    }, []);
    const Register = async (e) => {
        e.preventDefault();
        let result = await fetch("http://127.0.0.1:8000/api/register", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
            body: JSON.stringify({
                name: name,
                email: email,
                password: password
            }),
        }).then((res) => res.json())
            .then((json) => {
                sessionStorage.setItem("access_token", json.access_token);
                sessionStorage.setItem("data", json);
                if (json.access_token !== null) {
                    Swal.fire({
                        position: 'top-center',
                        icon: 'success',
                        title: 'Register Success',
                        showConfirmButton: false,
                        timer: 1500
                    })
                    history('/Register');
                }
            })
    };
    return (
        <div className='container mt-4 shadow-sm p-3 mb-5 bg-white rounded'>
            <Form onSubmit={Register}>
                <Form.Group className="mb-3" controlId="formBasicEmail">
                    <Form.Label>Name </Form.Label>
                    <Form.Control type="name" placeholder="Enter Name" value={name} onChange={(e) => setName(e.target.value)} />
                    <Form.Text className="text-muted">
                    </Form.Text>
                </Form.Group>
                <Form.Group className="mb-3" controlId="formBasicEmail">
                    <Form.Label>Email address</Form.Label>
                    <Form.Control type="email" placeholder="Enter email" value={email} onChange={(e) => setEmail(e.target.value)} />
                    <Form.Text className="text-muted">
                    </Form.Text>
                </Form.Group>
                <Form.Group className="mb-3" controlId="formBasicPassword">
                    <Form.Label>Password</Form.Label>
                    <Form.Control type="password" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)} />
                </Form.Group>
                <Form.Group className="mb-3" controlId="formBasicCheckbox">
                    <Form.Check type="checkbox" label="Check me out" />
                </Form.Group>
                <Button variant="primary" type="submit">
                    Submit
                </Button>
            </Form>
        </div>
    )
}
