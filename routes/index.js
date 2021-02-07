const express = require('express')
var router = express.Router();
const bodyParser = require('body-parser');
const mysql = require('mysql');
var formidable = require('formidable');
var fs = require('fs');
var path = require('path');

const con = mysql.createConnection({ host: 'localhost', port: '3308', user: 'root', password: '', database: 'pesmarica', debug: false, multipleStatements: true });

/* -----------------------------------> Prijava i Registracija <----------------------------------------------------- */

router.get('/korisnik_registracija', function(req, res, next) {
    res.render('korisnik_registracija');
});

router.post('/korisnik_registracija', function(req, res) {

    var korisnicko_ime = req.body.korisnicko_ime;

    let sql = "INSERT INTO korisnici (ime_prezime, korisnicko_ime, email, lozinka) VALUES ?";
    let values = [[req.body.ime_prezime, req.body.korisnicko_ime, req.body.email, req.body.lozinka]];

    con.query(sql, [values], (err, result) => {
        req.session.k_ulogovan = true;
        req.session.korisnicko_ime = korisnicko_ime;
        return res.redirect('/korisnik_pesme');
    });

});

router.get('/', function(req, res, next) {
  res.render('korisnik_prijava');
});

router.post('/korisnik', function(req, res) {

    var korisnicko_ime = req.body.korisnicko_ime;
    var lozinka = req.body.lozinka;
    if (korisnicko_ime && lozinka) {
        con.query('SELECT * FROM korisnici WHERE korisnicko_ime = ? AND lozinka = ?', [korisnicko_ime, lozinka], function(error, results, fields) {
            if (results.length > 0) {
                req.session.k_ulogovan = true;
                req.session.korisnicko_ime = korisnicko_ime;
                return res.redirect('/korisnik_pesme');
            } else {
                res.send('Pogrešno korisničko ime ili lozinka.');
            }
            res.end();
        });
    }

});

router.get('/administrator_prijava', function(req, res, next) {
  res.render('administrator_prijava');
});

router.post('/administrator', function(req, res) {

    var korisnicko_ime = req.body.korisnicko_ime;
    var lozinka = req.body.lozinka;
    if (korisnicko_ime && lozinka) {
        con.query('SELECT * FROM administrator WHERE korisnicko_ime = ? AND lozinka = ?', [korisnicko_ime, lozinka], function(error, results, fields) {
            if (results.length > 0) {
                req.session.a_ulogovan = true;
                req.session.korisnicko_ime = korisnicko_ime;
                return res.redirect('/administrator_korisnici');
            } else {
                res.send('Pogrešno korisničko ime ili lozinka.');
            }
            res.end();
        });
    }

});

/* --------------------------------------------------------------------------------------------------------- */

/* -----------------------------------> Administrator <----------------------------------------------------- */

router.get('/administrator_korisnici', function(req, res, next) {

    let sql = "SELECT * FROM korisnici";
    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            res.render('administrator_korisnici', { data: result });
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.post('/administrator_korisnici', (req, res) => {

    let sql = "INSERT INTO korisnici (ime_prezime, korisnicko_ime, email, lozinka) VALUES ?";
    let values = [[req.body.ime_prezime, req.body.korisnicko_ime, req.body.email, req.body.lozinka]];

    con.query(sql, [values], (err, result) => {
        if (req.session.a_ulogovan) {
            res.redirect('administrator_korisnici');
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.post('/administrator_korisnici/izmeni/:id', function(req, res, next) {

    var administrator = {
        "ime_prezime":req.body.ime_prezime,
        "korisnicko_ime": req.body.korisnicko_ime,
        "email": req.body.email,
        "lozinka":req.body.lozinka
    }

    con.query("UPDATE korisnici SET  ? WHERE id = " + req.params.id +";", administrator, function(err, results,fields) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_korisnici/izbrisi/:id', function(req, res) {

    let sql = "DELETE FROM korisnici WHERE id =" + req.params.id + ";";
    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_autori', function(req, res, next) {

    let sql = "SELECT * FROM autori";
    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            res.render('administrator_autori', { data: result });
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.post('/administrator_autori', (req, res) => {

    let sql = "INSERT INTO autori (ime_prezime) VALUES ?";
    let values = [[req.body.ime_prezime]];

    con.query(sql, [values], (err, result) => {
        if (req.session.a_ulogovan) {
            res.redirect('administrator_autori');
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.post('/administrator_autori/izmeni/:id', function(req, res, next) {

    var administrator = {
        "ime_prezime":req.body.ime_prezime
    }

    con.query("UPDATE autori SET  ? WHERE id = " + req.params.id +";", administrator, function(err, results,fields) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_autori/izbrisi/:id', function(req, res) {

    let sql = "DELETE FROM autori WHERE id =" + req.params.id + ";";
    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_zanrovi', function(req, res, next) {

    let sql = "SELECT * FROM zanrovi";
    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            res.render('administrator_zanrovi', { data: result });
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.post('/administrator_zanrovi', (req, res) => {

    let sql = "INSERT INTO zanrovi (naziv) VALUES ?";
    let values = [[req.body.naziv]];

    con.query(sql, [values], (err, result) => {
        if (req.session.a_ulogovan) {
            res.redirect('administrator_zanrovi');
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.post('/administrator_zanrovi/izmeni/:id', function(req, res, next) {

    var administrator = {
        "naziv":req.body.naziv
    }
    con.query("UPDATE zanrovi SET  ? WHERE id = " + req.params.id +";", administrator, function(err, results,fields) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_zanrovi/izbrisi/:id', function(req, res) {
    let sql = "DELETE FROM zanrovi WHERE id =" + req.params.id + ";";
    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_pesme', function(req, res, next) {

    let sql = "SELECT *, ime_autora(autor) AS ime_autora, naziv_zanra(zanr) AS naziv_zanra FROM pesme";
    let sql_1 = "SELECT id AS autor_id, ime_prezime FROM autori";
    let sql_2 = "SELECT id AS zanr_id, naziv FROM zanrovi";

    con.query(sql, function (err, pesme) {
        if (err) throw err;

        con.query(sql_1, function (err, autori) {
            if (err) throw err;

            con.query(sql_2, function (err, zanrovi) {
                if (err) throw err;

                else if (req.session.a_ulogovan) {
                    res.render('administrator_pesme', {data: pesme, data_1: autori, data_2: zanrovi});
                } else {
                    req.session.a_ulogovan = false;
                    res.redirect('/administrator_prijava');
                }

            });
        });

    });

});

router.post('/administrator_pesme', (req, res) => {

    let sql = "INSERT INTO pesme (naziv, autor, zanr, tonalitet, akordi, tekst) VALUES ?";
    let values = [[req.body.naziv, req.body.autor, req.body.zanr, req.body.tonalitet, req.body.akordi, req.body.tekst]];

    con.query(sql, [values], (err, result) => {
        if (req.session.a_ulogovan) {
            return res.redirect('/administrator_pesme');
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }

        con.end();

    });
});

router.post('/administrator_pesme/izmeni/:id', function(req, res, next) {

    var administrator = {
        "naziv":req.body.naziv,
        "autor":req.body.autor,
        "zanr":req.body.zanr,
        "tonalitet": req.body.tonalitet,
        "akordi": req.body.akordi,
        "tekst":req.body.tekst
    }

    con.query("UPDATE pesme SET  ? WHERE id = " + req.params.id +";", administrator, function(err, results,fields) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_pesme/izbrisi/:id', function(req, res) {
    let sql = "DELETE FROM pesme WHERE id =" + req.params.id + ";";
    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            return res.redirect(req.get('referer'));
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

router.get('/administrator_pesma/:id', function(req, res, next) {

    let sql = "SELECT *, ime_autora(autor) AS ime_autora, naziv_zanra(zanr) AS naziv_zanra FROM pesme WHERE pesme.id = "+ req.params.id +";";

    con.query(sql, function(err, result) {
        if (req.session.a_ulogovan) {
            res.render('administrator_pesma', {data: result});
        } else {
            req.session.a_ulogovan = false;
            res.redirect('/administrator_prijava');
        }
    });
});

/* --------------------------------------------------------------------------------------------------------- */

/* -----------------------------------> Korisnik <---------------------------------------------------------- */

router.get('/korisnik_pesme', function(req, res, next) {

    let sql = "SELECT *, ime_autora(autor) AS ime_autora, naziv_zanra(zanr) AS naziv_zanra FROM pesme";
    let sql_1 = "SELECT id AS autor_id, ime_prezime AS autor_ime FROM autori";
    let sql_2 = "SELECT id AS zanr_id, naziv AS zanr_naziv FROM zanrovi";

    con.query(sql, function (err, pesme) {
        if (err) throw err;

        con.query(sql_1, function (err, autori) {
            if (err) throw err;

            con.query(sql_2, function (err, zanrovi) {
                if (err) throw err;

                else if (req.session.k_ulogovan) {
                    res.render('korisnik_pesme', {data: pesme, data_1: autori, data_2: zanrovi});
                } else {
                    req.session.k_ulogovan = false;
                    res.redirect('/');
                }

            });
        });

    });

});

router.post('/korisnik_pesme_rezultati_pretrage', function(req, res, next) {

    var naziv = req.body.naziv;
    var autor = req.body.autor;
    var zanr = req.body.zanr;

    let str = "SELECT pesme.*, ime_autora(autor) AS ime_autora, naziv_zanra(zanr) AS naziv_zanra, autori.id AS autor_id, autori.ime_prezime AS autor_ime, zanrovi.id AS zanr_id, zanrovi.naziv AS zanr_naziv FROM pesme JOIN autori ON pesme.autor = autori.id JOIN zanrovi ON pesme.zanr = zanrovi.id";

    str += " WHERE ";

    if (naziv != ""){
        str += "pesme.naziv = '" + naziv + "' AND "
    }
    if (autor != ""){
        str += "pesme.autor = '" + autor + "' AND "
    }
    if (zanr != ""){
        str += "pesme.zanr = '" + zanr + "' AND "
    }

    str += "1";

    con.query(str, function(err, result) {
        if (req.session.k_ulogovan) {
            res.render('korisnik_pesme_rezultati_pretrage', {data: result});
        } else {
            req.session.k_ulogovan = false;
            res.redirect('/');
        }
    });

});

router.get('/korisnik_pesma/:id', function(req, res, next) {

    let sql = "SELECT *, ime_autora(autor) AS ime_autora, naziv_zanra(zanr) AS naziv_zanra FROM pesme WHERE pesme.id = "+ req.params.id +";";

    con.query(sql, function(err, result) {
        if (req.session.k_ulogovan) {
            res.render('korisnik_pesma', {data: result});
        } else {
            req.session.k_ulogovan = false;
            res.redirect('/');
        }
    });
});

/* --------------------------------------------------------------------------------------------------------- */

/* -----------------------------------> Logout <------------------------------------------------------------ */

router.get('/korisnik_logout',(req,res) => {
    req.session.destroy(function(err){
        if(err){
            console.log(err);
        }else{
            res.redirect('/');
        } res.end();
    });
});

router.get('/administrator_logout',(req,res) => {
    req.session.destroy(function(err){
        if(err){
            console.log(err);
        }else{

            res.redirect('/administrator_prijava');
        } res.end();
    });
});




module.exports = router;
